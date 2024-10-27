import 'package:flutter/material.dart';

import '../../supabase/supabase_auth.dart';
import 'auth_cubit.dart';

extension NetworkFunctions on AuthCubit {
  sendOTP(BuildContext context) async {
    try {
      emitLoading();
      await SupabaseAuth.sendOTP(emailController.text);
      toggleIsOtp();
    } catch (e) {
      emitError('The provided email could not be found!');
    }
  }

  verifyOTP(BuildContext context, int otp) async {
    var stringOtp = '$otp'.padLeft(6, '0');
    try {
      emitLoading();
      await SupabaseAuth.verifyOTP(emailController.text, stringOtp);
      emitUpdate();
      if (context.mounted) {
        navigateToEvents(context);
      }
    } catch (e) {
      emitError('Could not verify OTP');
    }
  }
}
