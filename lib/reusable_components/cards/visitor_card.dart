import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_organizer/model/user/visitor.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class VisitorCard extends StatelessWidget {
  const VisitorCard({
    super.key,
    required this.visitor,
  });
  final Visitor visitor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: context.bg2,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: context.textColor1.withOpacity(0.3),
                    blurRadius: 4,
                    spreadRadius: 0.5,
                    offset: Offset(3, 3))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: AspectRatio(
                              aspectRatio: 1, child: VisitorAvatar()),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(visitor.fName ?? '',
                                      style: context.bodyMedium,
                                      maxLines: 1,
                                      softWrap: true),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(visitor.lName ?? '',
                                      style: context.bodyMedium,
                                      maxLines: 1,
                                      softWrap: true),
                                ],
                              ),
                              Text(visitor.id ?? '',
                                  style: TextStyle(
                                      fontSize: context.bodySmall.fontSize,
                                      color: context.textColor1),
                                  maxLines: 3,
                                  softWrap: true),
                              Text('Front end',
                                  style: TextStyle(
                                      fontSize: context.bodySmall.fontSize,
                                      color: context.textColor1),
                                  maxLines: 3,
                                  softWrap: true),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VisitorAvatar extends StatelessWidget {
  const VisitorAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              context.primary,
              context.primary.withOpacity(0.9),
              context.primary.withOpacity(0.6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
            )
          ]),
      child: Icon(
        CupertinoIcons.person_solid,
        color: context.bg1,
        size: 35,
      ),
    );
  }
}
