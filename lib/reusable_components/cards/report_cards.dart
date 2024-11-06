import 'package:flutter/material.dart';
import 'package:q_flow_organizer/extensions/screen_size.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class ReportCards extends StatelessWidget {
  const ReportCards(
      {super.key,
      required this.onTap,
      required this.title,
      required this.icon});
  final Function() onTap;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: context.screenWidth * 0.6,
        width: context.screenWidth * 0.43,
        child: Card(
          color: context.bg2,
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  size: 60,
                  color: context.primary,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.bodyLarge.fontSize,
                    fontWeight: FontWeight.w600,
                    color: context.textColor1,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
