import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/reusable_components/indicator.dart';
import 'package:q_flow_organizer/reusable_components/page_header_view.dart';
import 'package:q_flow_organizer/screens/top_majors/network_functions.dart';
import 'package:q_flow_organizer/screens/top_majors/top_majors_cubit.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class TopMajorsScreen extends StatelessWidget {
  const TopMajorsScreen({super.key});
  final List<Color> orangeColors = const [
    Color(0xFFF16E00),
    Color(0xFFFF8C00),
    Color(0xFFFF7F50),
    Color(0xFFFFB26F),
    Color(0xFFFFB38E),
  ];

  @override
  Widget build(BuildContext context) {
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.1,
                          child: Card(
                            color: context.bg2,
                            child: PieChart(
                              PieChartData(
                                sections: showingSections(
                                    context,
                                    cubit.touchedIndex.value,
                                    cubit.skillValues),
                                borderData: FlBorderData(show: false),
                                centerSpaceRadius: 70,
                                sectionsSpace: 3,
                                pieTouchData: PieTouchData(
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection ==
                                            null) {
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
                        ),
                        SizedBox(height: 50),
                        Text(
                          'Top In-demand Majors List',
                          style: TextStyle(
                            fontSize: context.titleSmall.fontSize,
                            fontWeight: FontWeight.bold,
                            color: context.textColor1,
                          ),
                        ),
                        SizedBox(height: 20),
                        ...cubit.skillValues.entries.map((entry) {
                          final skill = entry.key;
                          final count = entry.value;
                          final index =
                              cubit.skillValues.keys.toList().indexOf(skill);

                          return Indicator(
                            color: orangeColors[index % orangeColors.length],
                            showIndicator: true,
                            text: skill,
                            icon: Icons.computer_rounded,
                            count: "$count",
                          );
                        }).toList(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  List<PieChartSectionData> showingSections(
      BuildContext context, int touchedIndex, Map<String, int> values) {
    return values.entries
        .toList()
        .asMap()
        .map((index, entry) {
          final title = entry.key;
          final value = entry.value;
          final isTouched = index == touchedIndex;

          final radius = isTouched ? 75.0 : 60.0; // Adjust radius
          final color = orangeColors[index % orangeColors.length];

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
