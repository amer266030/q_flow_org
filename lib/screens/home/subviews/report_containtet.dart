import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:q_flow_organizer/extensions/screen_size.dart';
import 'package:q_flow_organizer/model/enums/reports.dart';
import 'package:q_flow_organizer/model/user/company.dart';
import 'package:q_flow_organizer/reusable_components/cards/company_card.dart';
import 'package:q_flow_organizer/reusable_components/cards/visitor_card.dart';
import 'package:q_flow_organizer/screens/home/charts/bar_chart.dart';
import 'package:q_flow_organizer/screens/home/charts/line_chart.dart';
import 'package:q_flow_organizer/screens/home/charts/pie_chart.dart';
import 'package:q_flow_organizer/screens/home/home_cubit.dart';
import 'package:q_flow_organizer/screens/home/subviews/filter_item_view.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class ReportContent extends StatelessWidget {
  final BuildContext context;
  final HomeCubit cubit;

  ReportContent({
    required this.context,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    switch (cubit.selectedStatus) {
      case Reports.majors:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top In-demand Majors',
              style: TextStyle(
                fontSize: context.bodyLarge.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ValueListenableBuilder<int>(
                    valueListenable: cubit.touchedIndex,
                    builder: (context, value, child) {
                      return MajorsPieChartextends(
                        onTouch: (int index) {
                          cubit.touchedIndex.value =
                              index; // Update touched index
                        },
                        touchedIndex: value,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      case Reports.company:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Most applied for companies',
              style: TextStyle(
                fontSize: context.bodyLarge.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            CompanyBarChart(
              barGroups: _initializeBarGroups(context, cubit.companies),
              touchedGroupIndex: cubit.touchedGroupIndex,
              onTouched: (index) => cubit.updateTouchedGroupIndex(index),
              titles: cubit.companies
                  .map((c) => c.name)
                  .whereType<String>()
                  .toList(),
            ),
          ],
        );
      case Reports.rating:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details about Ratings',
              style: TextStyle(
                fontSize: context.bodyLarge.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FilterItemView(
                    itemValues: ["Company Rating", "Visitor Rating"],
                    setValueFunc: (str) => cubit.filterRating(str),
                    currentSelection: cubit.currantSelected,
                  ),
                ),
              ],
            ),
            if (cubit.currantSelected == "Company Rating")
              ...cubit.companies.map((company) {
                return CompanyCard(
                  company: company,
                  rateCompany: () =>
                      cubit.navigateToCompanyRating(context, company),
                );
              }).toList(),
            if (cubit.currantSelected == "Visitor Rating")
              ...cubit.visitors.map((visitor) {
                return VisitorCard(
                  visitor: visitor,
                  rateVisitor: () =>
                      cubit.navigateToVisitorRating(context, visitor),
                );
              }).toList(),
          ],
        );
      case Reports.times:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interviews peak hours',
              style: TextStyle(
                fontSize: context.bodyLarge.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: InterviewsLineChart(
                      textColor: context.textColor1,
                      lineColor: context.primary,
                      screenWidth: context.screenWidth,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      default:
        return Container();
    }
  }

  List<BarChartGroupData> _initializeBarGroups(
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
