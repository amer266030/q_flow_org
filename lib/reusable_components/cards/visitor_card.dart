import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_organizer/extensions/img_ext.dart';
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
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: visitor.avatarUrl == null
                            ? VisitorAvatar()
                            : FadeInImage(
                                placeholder: Img.logoOrange,
                                image: NetworkImage(visitor.avatarUrl ?? ''),
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return VisitorAvatar();
                                },
                              ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text("${visitor.fName} ${visitor.lName}",
                                style: TextStyle(
                                    fontSize: context.bodyLarge.fontSize,
                                    fontWeight: FontWeight.w600),
                                maxLines: 1,
                                softWrap: true),
                          ],
                        ),
                        Text(visitor.id ?? '',
                            style: TextStyle(
                              fontSize: context.bodyMedium.fontSize,
                            ),
                            maxLines: 1,
                            softWrap: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
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
          borderRadius: BorderRadius.circular(8),
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
