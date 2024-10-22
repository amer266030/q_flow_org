import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../extensions/img_ext.dart';
import '../../reusable_components/buttons/primary_btn.dart';
import '../../reusable_components/custom_text_field.dart';
import '../../reusable_components/page_header_view.dart';
import '../../utils/validations.dart';
import 'auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ImgView(),
                  PageHeaderView(title: 'Login'),
                  Expanded(
                    child: ListView(
                      children: [
                        _FormView(cubit: cubit),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _ImgView extends StatelessWidget {
  const _ImgView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // border: Border.all(color: context.primary, width: 2),
              ),
              width: 140,
              height: 140,
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 5,
                    child: ClipOval(
                        child: Image(
                            image: Img.logoTurquoise, fit: BoxFit.cover))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FormView extends StatelessWidget {
  const _FormView({required this.cubit});
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextField(
            hintText: 'Email',
            controller: TextEditingController(),
            validation: Validations.email),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
                child: PrimaryBtn(
                    callback: () => cubit.navigateToEvents(context),
                    title: 'Start'))
          ],
        ),
      ],
    );
  }
}
