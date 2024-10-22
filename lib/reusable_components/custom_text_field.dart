import 'package:flutter/material.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.max = 1,
    required this.controller,
    required this.validation,
    this.onChanged,
    this.readOnly = false,
    this.isObscure = false,
  });
  final String hintText;
  final Widget? prefixIcon;
  final int? max;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final Function(String value) validation;
  final bool readOnly;
  final bool isObscure;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        style: context.bodyLarge,
        readOnly: readOnly,
        obscureText: isObscure,
        maxLines: max,
        // obscureText: ,
        onChanged: onChanged,
        minLines: 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: context.primary,
            fontSize: context.bodySmall
                .fontSize, // Optional: Adjust the font size of the error message
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          contentPadding: const EdgeInsets.all(16),
          prefixIcon: prefixIcon,
          prefixIconColor: context.primary,
          suffixIcon: suffixIcon,
          suffixIconColor: context.primary,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(color: Colors.transparent)),
          filled: true,
          fillColor: context.bg2,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: context.bodyLarge.fontSize, color: context.textColor2),
        ),
        validator: (value) => validation(value ?? ''),
      ),
    );
  }
}
