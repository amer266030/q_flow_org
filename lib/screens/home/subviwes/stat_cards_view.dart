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
    required this.viewCompanies,
    required this.viewInterviews,
    required this.viewVisitors,
  });

  final int numCompanies;
  final int numVisitors;
  final int numInterviews;
  final int totalInvitedVisitors;
  final Function() viewCompanies;
  final Function() viewInterviews;
  final Function() viewVisitors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90, left: 4, right: 4),
              child: InkWell(
                onTap: viewCompanies,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: context.screenWidth * 0.26,
                      width: context.screenWidth * 0.26,
                      child: Card(
                        color: context.bg2,
                        shape: CircleBorder(),
                        elevation: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.business_rounded,
                                color: context.textColor1,
                              ),
                              Text(
                                '$numCompanies',
                                style: TextStyle(
                                  fontSize: context.titleSmall.fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: context.primary,
                                ),
                              ),
                              Text(
                                'Companies',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: context.bodyMedium.fontSize,
                                  color: context.textColor1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // if (totalInvitedCompanies == 0)
                    //   Container()
                    // else
                    Container(
                      height: context.screenWidth * 0.26,
                      width: context.screenWidth * 0.26,
                      child: CircularProgressIndicator(
                        strokeWidth: 7,
                        color: context.primary,
                        backgroundColor: context.bg1,
                        //value: numCompanies/totalInvitedCompanies
                        value: 30 / 100,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: viewInterviews,
          child: Container(
            height: context.screenWidth * 0.3,
            width: context.screenWidth * 0.3,
            child: Card(
              color: context.bg2,
              shape: CircleBorder(),
              elevation: 6,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(CupertinoIcons.rectangle_stack_person_crop),
                    Text(
                      '$numInterviews',
                      style: TextStyle(
                        fontSize: context.titleSmall.fontSize,
                        fontWeight: FontWeight.bold,
                        color: context.primary,
                      ),
                    ),
                    Text(
                      'Interviews',
                      style: TextStyle(
                        fontSize: context.bodyLarge.fontSize,
                        color: context.textColor1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0, top: 90, left: 4),
              child: InkWell(
                onTap: viewVisitors,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: context.screenWidth * 0.26,
                      width: context.screenWidth * 0.26,
                      child: Card(
                        color: context.bg2,
                        shape: CircleBorder(),
                        elevation: 9,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                CupertinoIcons.person_3_fill,
                              ),
                              Text(
                                '$numVisitors',
                                style: TextStyle(
                                  fontSize: context.titleSmall.fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: context.primary,
                                ),
                              ),
                              Text(
                                'Visitors',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: context.bodyMedium.fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: context.textColor1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // if (totalInvitedVisitors == 0)
                    //   Container()
                    // else
                    Container(
                      height: context.screenWidth * 0.26,
                      width: context.screenWidth * 0.26,
                      child: CircularProgressIndicator(
                        strokeWidth: 7,
                        color: context.primary,
                        backgroundColor: context.bg1,
                        //value: numVisitors / totalInvitedVisitors,
                        value: 70 / 100,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
