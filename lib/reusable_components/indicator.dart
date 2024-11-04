import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    this.color,
    required this.text,
    this.size = 16,
    this.showIndicator = true,
    this.icon,
    this.count,
  });

  final Color? color;
  final String text;
  final double size;
  final bool showIndicator;
  final IconData? icon;
  final String? count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            if (showIndicator)
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: color,
                ),
              ),
            const SizedBox(
              width: 4,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: context.bodyLarge.fontSize,
                  fontWeight: FontWeight.bold,
                  color: context.textColor2),
            ),
            Spacer(),
            Text(
              count ?? "",
              style: TextStyle(
                  fontSize: context.bodyLarge.fontSize,
                  color: context.textColor3),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
              icon,
              color: context.textColor3,
              size: 15,
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}
