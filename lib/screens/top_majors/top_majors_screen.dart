import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/reusable_components/indicator.dart';
import 'package:q_flow_organizer/reusable_components/page_header_view.dart';
import 'package:q_flow_organizer/screens/top_majors/top_majors_cubit.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class TopMajorsScreen extends StatelessWidget {
  const TopMajorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> data = {
      'Front-end Development': context.primary,
      'Back-end Development': context.primary.withOpacity(0.8),
      'Cybersecurity': context.primary.withOpacity(0.7),
      'Web Development': context.primary.withOpacity(0.6),
      'Mobile Development': context.primary.withOpacity(0.5),
    };

    return BlocProvider(
      create: (context) => TopMajorsCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<TopMajorsCubit>();
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: [
                PageHeaderView(title: 'Top In-demand\nMajors Chart'),
                BlocBuilder<TopMajorsCubit, TopMajorsState>(
                  builder: (context, state) {
                    return AspectRatio(
                      aspectRatio: 1.1,
                      child: Card(
                        color: context.bg2,
                        child: PieChart(
                          PieChartData(
                            sections: showingSections(
                                context, cubit.touchedIndex.value),
                            borderData: FlBorderData(show: false),
                            centerSpaceRadius: 70,
                            sectionsSpace: 3,
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  cubit.updateTouchedIndex(
                                      -1); // Reset touched index
                                  return;
                                }
                                final index = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                                cubit.updateTouchedIndex(
                                    index); // Update touched index
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'List of Majors',
                        style: TextStyle(
                            fontSize: context.titleSmall.fontSize,
                            fontWeight: FontWeight.bold,
                            color: context.textColor1),
                      ),
                      SizedBox(height: 20),
                      ...data.entries.map((entry) {
                        return Indicator(
                          color: entry.value,
                          text: entry.key,
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  List<PieChartSectionData> showingSections(
      BuildContext context, int touchedIndex) {
    final Map<String, int> values = {
      'Front-end Development': 30,
      'Back-end Development': 10,
      'Cybersecurity': 10,
      'Web Development': 10,
      'Mobile Development': 10,
    };

    return values.entries
        .toList()
        .asMap()
        .map((index, entry) {
          final title = entry.key;
          final value = entry.value;
          final isTouched = index == touchedIndex;

          final radius = isTouched ? 80.0 : 70.0; // Adjust radius
          final color = context.primary
              .withOpacity((0.8 - (index * 0.1)).clamp(0.1, 1.0));

          return MapEntry(
            title,
            PieChartSectionData(
              color: color,
              value: value.toDouble(),
              title: '',
              radius: radius,
            ),
          );
        })
        .values
        .toList();
  }
}
