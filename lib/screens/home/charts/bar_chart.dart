import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_organizer/screens/home/home_screen.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

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
                          return Transform.rotate(
                            angle:
                                -0.485398, // Rotate 45 degrees counter-clockwise
                            child: Text(
                              titles[value.toInt()],
                              style: TextStyle(
                                  fontSize: context.bodySmall.fontSize,
                                  color: context.textColor2),
                            ),
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
                  borderData: FlBorderData(show: false),
                  barGroups: barGroups,
                  gridData: const FlGridData(show: false),
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
      color: Colors.black,
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

  Widget bottomTitles(double value, TitleMeta meta) {
    if (value.toInt() >= titles.length) return Container();

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(
        titles[value.toInt()],
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
