import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/screens/home/home_screen.dart';

import '../events/events_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  navigateToEvents(BuildContext context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => EventsScreen()));
}
