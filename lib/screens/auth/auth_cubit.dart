import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  navigateToEvents(BuildContext context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => EventsScreen()));

  @override
  void emit(AuthState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitLoading() => emit(LoadingState());
  emitUpdate() => emit(UpdateUIState());
  emitError(String msg) => emit(ErrorState(msg));
}
