import 'package:flutter/material.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

import '../../../extensions/img_ext.dart';
import '../../../model/event/event.dart';

class EventItemView extends StatelessWidget {
  const EventItemView({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: context.bg3,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: context.textColor1.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: event.imgUrl == null
                      ? Image(image: Img.logoPurple, fit: BoxFit.cover)
                      : Image.network(event.imgUrl!, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  children: [
                    Text(
                      event.name ?? '',
                      style: TextStyle(
                        fontSize: context.bodyLarge.fontSize,
                        fontWeight: FontWeight.bold,
                        color: context.textColor1,
                      ),
                      softWrap: true,
                      maxLines: 2,
                    ),
                    Text(
                      '${event.startDate ?? ''} - ${event.endDate ?? ''}',
                      style: TextStyle(
                        fontSize: context.bodySmall.fontSize,
                        color: context.textColor3,
                      ),
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
