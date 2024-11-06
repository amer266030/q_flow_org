import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/reusable_components/animated_snack_bar.dart';
import 'package:q_flow_organizer/utils/validations.dart';

import '../events/events_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthState? previousState;
  AuthCubit() : super(AuthInitial());

  var isOtp = false;
  var emailController = TextEditingController();

  toggleIsOtp() {
    isOtp = !isOtp;
    emitUpdate();
  }
    bool validateEmail(BuildContext context) {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      showSnackBar(
          context, 'Email cannot be empty.', AnimatedSnackBarType.warning);
      return false;
    }
    final validationMessage = Validations.email(email);
    if (validationMessage != null) {
      showSnackBar(context, validationMessage, AnimatedSnackBarType.warning);
      return false;
    }
    return true;
  }

  navigateToEvents(BuildContext context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => EventsScreen()));
 void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }

  @override
  void emit(AuthState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitLoading() => emit(LoadingState());
  emitUpdate() => emit(UpdateUIState());
  emitError(String msg) => emit(ErrorState(msg));
}
