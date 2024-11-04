import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/model/rating/company_rating_question.dart';
import 'package:q_flow_organizer/reusable_components/dialogs/error_dialog.dart';
import 'package:q_flow_organizer/reusable_components/dialogs/loading_dialog.dart';
import 'package:q_flow_organizer/reusable_components/indicator.dart';
import 'package:q_flow_organizer/reusable_components/page_header_view.dart';
import 'package:q_flow_organizer/screens/company_rating/company_rating_cubit.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class CompanyRatingScreen extends StatelessWidget {
  final List<CompanyRatingQuestion> questions;

  const CompanyRatingScreen({
    Key? key,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyRatingCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<CompanyRatingCubit>();
        return BlocListener<CompanyRatingCubit, CompanyRatingState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showLoadingDialog(context);
            } else if (state is ErrorState) {
              showErrorDialog(context, state.msg);
            }
          },
          child: Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListView(
                  children: [
                    BlocBuilder<CompanyRatingCubit, CompanyRatingState>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return Center(child: CircularProgressIndicator());
                        } else if (cubit.questions.isEmpty ||
                            cubit.questionAvgRatings.isEmpty) {
                          return Center(child: Text("No data available."));
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PageHeaderView(title: 'Rating Companies \nChart'),
                            SizedBox(height: 20),
                            RatingCompaniesBarChart(
                              touchedGroupIndex: cubit.touchedGroupIndex,
                              questions: cubit.questions,
                              questionAvgRatings: cubit.questionAvgRatings,
                              onTouch: (index) {
                                cubit.updateTouchedGroupIndex(index);
                              },
                            ),
                            SizedBox(height: 50),
                            Text(
                              'Rating Questions List',
                              style: TextStyle(
                                fontSize: context.titleSmall.fontSize,
                                fontWeight: FontWeight.bold,
                                color: context.textColor1,
                              ),
                            ),
                            SizedBox(height: 20),
                            ...cubit.questions.asMap().entries.map((entry) {
                              int index = entry.key;
                              CompanyRatingQuestion question = entry.value;

                              return Indicator(
                                icon: CupertinoIcons.star_fill,
                                showIndicator: false,
                                text: 'Q${index + 1}: ${question.title}',
                                count:
                                    "${cubit.questionAvgRatings[question.id]?.toStringAsFixed(1) ?? 0.0}",
                              );
                            }).toList(),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class RatingCompaniesBarChart extends StatelessWidget {
  final int touchedGroupIndex;
  final List<CompanyRatingQuestion> questions;
  final Map<String, double> questionAvgRatings;
  final ValueChanged<int> onTouch;

  RatingCompaniesBarChart({
    Key? key,
    required this.touchedGroupIndex,
    required this.questions,
    required this.questionAvgRatings,
    required this.onTouch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        color: context.bg2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 38),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: BarChart(
                    mainBarData(context, touchedGroupIndex),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  BarChartData mainBarData(BuildContext context, int touchedIndex) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => context.bg1,
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            if (touchedIndex == group.x) {
              String? questionTitle = questions[group.x].title;

              return BarTooltipItem(
                '$questionTitle\n',
                TextStyle(
                  color: context.textColor3,
                  fontWeight: context.titleMedium.fontWeight,
                  fontSize: context.bodySmall.fontSize,
                ),
                children: [
                  TextSpan(
                    text: rod.toY.toStringAsFixed(1).toString(),
                    style: TextStyle(
                      color: context.textColor3,
                      fontWeight: context.titleMedium.fontWeight,
                      fontSize: context.bodySmall.fontSize,
                    ),
                  ),
                ],
              );
            } else {
              return null; // No tooltip for non-touched bars
            }
          },
        ),
        touchCallback: (FlTouchEvent event, BarTouchResponse? response) {
          if (event is FlTapDownEvent &&
              response != null &&
              response.spot != null) {
            final index = response.spot!.touchedBarGroupIndex;
            onTouch(index); // Call the onTouch callback
          } else {
            onTouch(-1); // Reset if not touching
          }
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => getTitles(value, meta, context),
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                TextStyle titleStyle = TextStyle(
                  color: context.textColor2,
                  fontWeight: context.titleMedium.fontWeight,
                  fontSize: context.bodyMedium.fontSize,
                );

                if (value % 1 == 0 && value >= 0 && value <= 5) {
                  return Text(value.toInt().toString(), style: titleStyle);
                }
                return Container();
              }),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: barGroups(context),
      gridData: const FlGridData(show: false),
    );
  }

  List<BarChartGroupData> barGroups(BuildContext context) {
    return questionAvgRatings.entries.toList().asMap().entries.map((entry) {
      int index = entry.key;
      double rating = entry.value.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: rating,
            gradient: _barsGradient(context),
          ),
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();
  }

  LinearGradient _barsGradient(BuildContext context) => LinearGradient(
        colors: [context.primary, context.secondary],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  Widget getTitles(double value, TitleMeta meta, BuildContext context) {
    final style = TextStyle(
      color: context.textColor2,
      fontWeight: context.titleMedium.fontWeight,
      fontSize: context.bodyMedium.fontSize,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text('Q${value.toInt() + 1}', style: style),
    );
  }
}
