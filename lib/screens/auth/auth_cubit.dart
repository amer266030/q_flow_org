import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../supabase/supabase_auth.dart';
import '../events/events_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  var isOtp = false;
  var emailController = TextEditingController();

  toggleIsOtp() {
    isOtp = !isOtp;
    emitUpdate();
  }

  Future signIn(BuildContext context) async {
    try {
      emitLoading();
      var response = await SupabaseAuth.signIn(emailController.text);
      print(response.toString());
      emitUpdate();
      if (context.mounted) {
        navigateToEvents(context);
      }
    } catch (e) {
      print(e.toString());
      emitUpdate();
    }
  }

  verifyOTP(BuildContext context, int otp) async {
    print('This was called');
    navigateToEvents(context);
  }

  navigateToEvents(BuildContext context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => EventsScreen()));

  emitLoading() => emit(LoadingState());
  emitUpdate() => emit(UpdateUIState());
}
