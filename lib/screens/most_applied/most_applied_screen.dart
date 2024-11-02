import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/model/user/company.dart';
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
        return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PageHeaderView(
                            title: 'Most applied for\nCompanies Chart'),
                        SizedBox(
                          height: 20,
                        ),
                        CompanyBarChart(
                          barGroups:
                              initializeBarGroups(context, cubit.companies),
                          touchedGroupIndex: cubit.touchedGroupIndex,
                          onTouched: (index) =>
                              cubit.updateTouchedGroupIndex(index),
                          titles: cubit.companies
                              .map((c) => c.name)
                              .whereType<String>()
                              .toList(),
                        ),
                        Text(
                          'Companies List',
                          style: TextStyle(
                              fontSize: context.titleSmall.fontSize,
                              fontWeight: FontWeight.bold,
                              color: context.textColor1),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Indicator(
                          color: context.secondary,
                          text: 'Company A',
                          textColor: context.textColor2,
                        ),
                      ]),
                ],
              ),
            ));
      }),
    );
  }

  List<BarChartGroupData> initializeBarGroups(
      BuildContext context, List<Company> companies) {
    const width = 7.0;

    return companies.asMap().entries.map((entry) {
      int index = entry.key;
      Company company = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
              toY: 5.0 + index,
              color: context.primary,
              width: width), // Example data
          BarChartRodData(
              toY: 10.0 + index,
              color: context.secondary,
              width: width), // Example data
        ],
      );
    }).toList();
  }
}

class CompanyBarChart extends StatelessWidget {
  const CompanyBarChart({
    required this.barGroups,
    required this.touchedGroupIndex,
    required this.onTouched,
    required this.titles,
    super.key,
  });

  final List<BarChartGroupData> barGroups;
  final int touchedGroupIndex;
  final ValueChanged<int> onTouched;
  final List<String> titles; // Ensure this is a list of Strings

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 38),
            Expanded(
              child: Card(
                color: context.bg2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BarChart(
                    BarChartData(
                      maxY: 20,
                      barTouchData: BarTouchData(
                        touchCallback: (FlTouchEvent event, response) {
                          if (response == null || response.spot == null) {
                            onTouched(-1);
                            return;
                          }
                          int touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;
                          onTouched(touchedGroupIndex);
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
                              return Text(
                                titles[value.toInt()],
                                style: TextStyle(
                                    fontSize: context.bodySmall.fontSize,
                                    color: context.textColor2),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            interval: 1,
                            getTitlesWidget: leftTitles,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.black.withOpacity(0.1), width: 2),
                          left: BorderSide(
                              color: Colors.black.withOpacity(0.1), width: 2),
                          right: const BorderSide(color: Colors.transparent),
                          top: const BorderSide(color: Colors.transparent),
                        ),
                      ),
                      barGroups: barGroups,
                      gridData: const FlGridData(show: false),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.darkText2,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text;
    if (value == 0) {
      text = '100';
    } else if (value == 10) {
      text = '200';
    } else if (value == 19) {
      text = '300';
    } else {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }
}
