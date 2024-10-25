import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class MajorsPieChartextends extends StatelessWidget {
  MajorsPieChartextends({
    super.key,
    required this.onTouch,
    this.touchedIndex = -1,
  });
  final ValueChanged<int> onTouch;
  final int touchedIndex;

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> data = {
      'Front-end Development': context.primary,
      'Back-end Development': context.primary.withOpacity(0.9),
      'Cybersecurity': context.primary.withOpacity(0.8),
      'Web Development': context.primary.withOpacity(0.7),
      'Mobile Development': context.primary.withOpacity(0.6),
      'Software Engineering': context.primary.withOpacity(0.5),
      'Machine Learning': context.primary.withOpacity(0.4),
      'DevOps': context.primary.withOpacity(0.3),
      'AI': context.primary.withOpacity(0.2),
      'Data Science': context.primary.withOpacity(0.1),
    };

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: PieChart(
              PieChartData(
                sections: showingSections(context),
                borderData: FlBorderData(show: false),
                centerSpaceRadius: 40,
                sectionsSpace: 0,
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      onTouch(-1);
                      return;
                    }
                    final index =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                    onTouch(index);
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'List of Majors',
                style: TextStyle(
                  fontSize: context.bodyLarge.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ...data.entries.map((entry) {
                return Indicator(
                  color: entry.value,
                  text: entry.key,
                  isSquare: true,
                );
              }).toList(),
            ],
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(BuildContext context) {
    final Map<String, int> values = {
      'Front-end Development': 30,
      'Back-end Development': 10,
      'Cybersecurity': 10,
      'Web Development': 10,
      'Mobile Development': 10,
      'Software Engineering': 5,
      'Machine Learning': 5,
      'DevOps': 5,
      'AI': 5,
      'Data Science': 5,
    };

    return values.entries
        .toList()
        .asMap()
        .map((index, entry) {
          final title = entry.key;
          final value = entry.value;
          final isTouched =
              index == touchedIndex; // Check if this section is touched

          final radius = isTouched ? 80.0 : 70.0; // Adjust radius
          final color = context.primary
              .withOpacity((0.9 - (index * 0.1)).clamp(0.1, 1.0));

          return MapEntry(
            title,
            PieChartSectionData(
              color: color,
              value: value.toDouble(),
              title: '$value%',
              radius: radius,
            ),
          );
        })
        .values
        .toList();
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
