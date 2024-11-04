import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/model/user/company.dart';
import 'package:q_flow_organizer/reusable_components/dialogs/error_dialog.dart';
import 'package:q_flow_organizer/reusable_components/dialogs/loading_dialog.dart';
import 'package:q_flow_organizer/reusable_components/indicator.dart';
import 'package:q_flow_organizer/reusable_components/page_header_view.dart';
import 'package:q_flow_organizer/screens/most_applied/most_applied_cubit.dart';
import 'package:q_flow_organizer/theme_data/app_colors.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class MostAppliedScreen extends StatelessWidget {
  const MostAppliedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MostAppliedCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<MostAppliedCubit>();
        return BlocListener<MostAppliedCubit, MostAppliedState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showLoadingDialog(context);
            } else if (state is ErrorState) {
              showErrorDialog(context, state.msg);
              print(state.msg);
            }
          },
          child: Scaffold(
              appBar: AppBar(),
              body: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: BlocBuilder<MostAppliedCubit, MostAppliedState>(
                    builder: (context, state) {
                      // Handle loading state
                      if (state is LoadingState) {
                        return Center(child: CircularProgressIndicator());
                      }

                      // Handle error state
                      if (state is ErrorState) {
                        return Center(child: Text(""));
                      }

                      // Assume the state is loaded and we have companies
                      final cubit = context.read<MostAppliedCubit>();

                      return ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PageHeaderView(
                                title: 'Most Applied for\nCompanies Chart',
                              ),
                              // Use the CompanyInterviewsBarChart here
                              CompanyInterviewsBarChart(
                                touchedGroupIndex: cubit.touchedGroupIndex,
                                companies: cubit
                                    .companies, // Pass the list of companies
                                onTouch: (index) {
                                  cubit.updateTouchedGroupIndex(
                                      index); // Update touched index
                                },
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Companies List',
                                style: TextStyle(
                                  fontSize: context.titleSmall.fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: context.textColor1,
                                ),
                              ),
                              SizedBox(height: 20),
                              ...cubit.companies.asMap().entries.map((entry) {
                                int index =
                                    entry.key + 1; // Use index + 1 for display
                                var company = entry.value;
                                return Indicator(
                                  icon: CupertinoIcons
                                      .rectangle_stack_person_crop_fill,
                                  showIndicator: false,
                                  text:
                                      "C$index: ${company['companyName']}", // Prefix with the number
                                  count:
                                      "${company['interviewCount']}", // Display interview count
                                );
                              }).toList(),
                            ],
                          ),
                        ],
                      );
                    },
                  ))),
        );
      }),
    );
  }
}

class CompanyInterviewsBarChart extends StatelessWidget {
  final int touchedGroupIndex;
  final List<Map<String, dynamic>>
      companies; // List of maps with company names and interview counts
  final ValueChanged<int> onTouch;

  CompanyInterviewsBarChart({
    Key? key,
    required this.touchedGroupIndex,
    required this.companies,
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
              String companyName =
                  companies[group.x]['companyName']; // Get company name
              int interviewCount =
                  companies[group.x]['interviewCount']; // Get interview count

              return BarTooltipItem(
                '$companyName\n',
                TextStyle(
                  color: context.textColor3,
                  fontWeight: context.titleMedium.fontWeight,
                  fontSize: context.bodySmall.fontSize,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: interviewCount.toString(),
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
            getTitlesWidget: (value, meta) {
              // Show index as title (number)
              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 16,
                child: Text(
                  "C${(value.toInt() + 1)}", // Display index as number
                  style: TextStyle(
                    color: context.textColor2,
                    fontWeight: context.titleMedium.fontWeight,
                    fontSize: context.bodyMedium.fontSize,
                  ),
                ),
              );
            },
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 25,
            // getTitlesWidget: (value, meta) {
            //   //print(value);
            //   const List<double> uniqueValues = [
            //     0,
            //     1,
            //     2,
            //     3
            //   ]; // Adjust as needed

            //   if (uniqueValues.contains(value)) {
            //     TextStyle titleStyle = TextStyle(
            //       color: context.textColor2,
            //       fontWeight: context.titleMedium.fontWeight,
            //       fontSize: context.bodyMedium.fontSize,
            //     );

            //     return Text(
            //       value.toInt().toString(),
            //       style: titleStyle,
            //     );
            //   } else {
            //     return SizedBox(); // Return an empty widget for non-integer values
            //   }
            // },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: barGroups(context),
      gridData: const FlGridData(show: false),
    );
  }

  List<BarChartGroupData> barGroups(BuildContext context) {
    return companies.asMap().entries.map((entry) {
      int index = entry.key;
      int interviewCount = entry.value['interviewCount']; // Get interview count

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: interviewCount.toDouble(),
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
}
