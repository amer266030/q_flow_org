import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_organizer/extensions/screen_size.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class StatCardsView extends StatelessWidget {
  const StatCardsView({
    super.key,
    required this.numCompanies,
    required this.numVisitors,
    required this.numInterviews,
    required this.totalInvitedVisitors,
    required this.totalInvitedCompanies,
    required this.viewCompanies,
    required this.viewInterviews,
    required this.viewVisitors,
  });

  final int numCompanies;
  final int numVisitors;
  final int numInterviews;
  final int totalInvitedVisitors;
  final int totalInvitedCompanies;
  final Function() viewCompanies;
  final Function() viewInterviews;
  final Function() viewVisitors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CircleCard(
                      currentNum: numInterviews,
                      totalNum: 1,
                      callback: viewInterviews,
                      title: 'Interviews',
                      icon: CupertinoIcons.rectangle_stack_person_crop),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleCard(
                      currentNum: numCompanies,
                      totalNum: totalInvitedCompanies,
                      callback: viewCompanies,
                      title: 'Companies',
                      icon: Icons.business_rounded),
                  _CircleCard(
                      currentNum: numVisitors,
                      totalNum: totalInvitedVisitors,
                      callback: viewVisitors,
                      title: 'Visitors',
                      icon: CupertinoIcons.person_3_fill),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleCard extends StatelessWidget {
  const _CircleCard({
    required this.currentNum,
    required this.totalNum,
    required this.callback,
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;
  final int currentNum;
  final int totalNum;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: context.screenWidth * 0.3,
            child: AspectRatio(
              aspectRatio: 1,
              child: Card(
                color: context.bg2,
                shape: CircleBorder(),
                elevation: 12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(icon, color: context.textColor1),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: context.bodySmall.fontSize,
                          color: context.textColor1,
                        ),
                      ),
                      Text(
                        '$currentNum',
                        style: TextStyle(
                          fontSize: context.bodyLarge.fontSize,
                          fontWeight: FontWeight.bold,
                          color: context.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: context.screenWidth * 0.3,
            child: AspectRatio(
              aspectRatio: 1,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                color: context.primary,
                backgroundColor:
                    currentNum == 0 ? Colors.transparent : context.bg1,
                value: currentNum / totalNum,
                strokeCap: StrokeCap.round,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
