import 'package:flutter/material.dart';

import '../../../reusable_components/buttons/primary_btn.dart';
import '../../../reusable_components/custom_text_field.dart';
import '../../../reusable_components/page_header_view.dart';
import '../../../utils/validations.dart';

class LoginFormView extends StatelessWidget {
  const LoginFormView(
      {super.key, required this.callback, required this.controller});
  final TextEditingController controller;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageHeaderView(title: 'Login'),
        CustomTextField(
            hintText: 'Email',
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            validation: Validations.email),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(child: PrimaryBtn(callback: callback, title: 'Start'))
          ],
        ),
      ],
    );
  }
}
