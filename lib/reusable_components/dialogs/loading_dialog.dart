import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_organizer/extensions/img_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

AwesomeDialog showLoadingDialog(BuildContext context) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    padding: EdgeInsets.symmetric(vertical: 24),
    dialogBorderRadius: BorderRadius.circular(24),
    dialogBackgroundColor: context.bg1,
    barrierColor: context.textColor1.withOpacity(0.4),
    dismissOnTouchOutside: false,
    animType: AnimType.scale,
    body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: Image(
            image: Img.loading,
          ),
        ),
        SizedBox(height: 16),
        Text('Please wait...', style: context.bodyMedium),
      ],
    ),
  )..show();
}
