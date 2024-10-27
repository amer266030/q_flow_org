import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/screens/auth/subviews/login_form_view.dart';
import 'package:q_flow_organizer/screens/auth/subviews/otp_form_view.dart';

import '../../extensions/img_ext.dart';
import 'auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: ClipOval(
                          child: AspectRatio(
                        aspectRatio: 2.3,
                        child: Image(
                          image: Img.logo,
                        ),
                      )),
                    ),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return cubit.isOtp
                            ? OtpFormView(
                                email: cubit.emailController.text,
                                goBack: cubit.toggleIsOtp,
                                verifyOTP: (otp) =>
                                    cubit.verifyOTP(context, otp))
                            : LoginFormView(
                                controller: cubit.emailController,
                                callback: () => cubit.signIn(context));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
