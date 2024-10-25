import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/extensions/img_ext.dart';
import 'package:q_flow_organizer/extensions/screen_size.dart';
import 'package:q_flow_organizer/model/rating/company_rating_question.dart';
import 'package:q_flow_organizer/model/user/company.dart';
import 'package:q_flow_organizer/screens/company_rating.dart/company_rating_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:q_flow_organizer/screens/home/charts/pie_chart.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class CompanyRatingScreen extends StatelessWidget {
  final Company company; // Accept the company as a parameter
  final List<CompanyRatingQuestion> questions;

  const CompanyRatingScreen({
    Key? key,
    required this.questions,
    required this.company, // Require the company parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyRatingCubit()..loadQuestions(questions),
      child: Builder(builder: (context) {
        final cubit = context.read<CompanyRatingCubit>();
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: [
                BlocBuilder<CompanyRatingCubit, CompanyRatingState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image(
                                  image: Img.logoPurple,
                                  fit: BoxFit.contain,
                                  width: context.screenWidth * 0.1,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                company.name ??
                                    'Company Name', // Display company name
                                style: context.titleSmall,
                                maxLines: 1,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Rating Chart',
                          style: TextStyle(
                            fontSize: context.bodyLarge.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        AspectRatio(aspectRatio: 1.2, child: _BarChart()),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Rating Questions List',
                          style: TextStyle(
                            fontSize: context.bodyLarge.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Indicator(
                          color: context.secondary,
                          text: 'Satisfaction',
                          isSquare: true,
                          textColor: context.textColor2,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          )),
        );
      }),
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData(context),
        titlesData: titlesData(context),
        borderData: borderData,
        barGroups: barGroups(context),
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 5,
      ),
    );
  }

  BarTouchData barTouchData(BuildContext context) => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 4,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: context.primary, // Use Context.Primary directly
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta, BuildContext context) {
    final style = TextStyle(
      color: context.textColor2,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Satisfaction';
        break;
      case 1:
        text = 'Interviewer';
        break;
      case 2:
        text = 'Clarity';
        break;
      case 3:
        text = 'Time';
        break;
      case 4:
        text = 'Fairness';
        break;
      case 5:
        text = 'setting';
        break;
      case 6:
        text = 'feedback';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Transform.rotate(
        angle: -0.5, // Rotate by -30 degrees (adjust as needed)
        child: Text(text, style: style),
      ),
    );
  }

  FlTitlesData titlesData(BuildContext context) => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) =>
                getTitles(value, meta, context), // Pass context here
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(show: false);

  LinearGradient _barsGradient(BuildContext context) => LinearGradient(
        colors: [context.primary, context.secondary],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> barGroups(BuildContext context) => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 2,
              gradient: _barsGradient(context),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 5,
              gradient: _barsGradient(context),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 4,
              gradient: _barsGradient(context),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 3,
              gradient: _barsGradient(context),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 3,
              gradient: _barsGradient(context),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 1,
              gradient: _barsGradient(context),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 5,
              gradient: _barsGradient(context),
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
