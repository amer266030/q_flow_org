import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_organizer/screens/add_event/add_event_screen.dart';
import 'package:q_flow_organizer/screens/auth/auth_screen.dart';
import 'package:q_flow_organizer/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme_data/app_theme_cubit.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit(BuildContext context) : super(EventsInitial()) {
    initialLoad(context);
  }

  bool isNotificationsEnabled = false;
  bool isDarkMode = true;
  bool isEnglish = true;

  initialLoad(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    isNotificationsEnabled =
        (prefs.getString('notifications').toString() == 'true');
    final savedTheme = prefs.getString('theme');
    isDarkMode = (savedTheme == ThemeMode.dark.toString());
    final savedLocale = prefs.getString('locale');
    isEnglish = (savedLocale == 'en_US' || savedLocale == 'true');
    emitUpdate();
  }

  void toggleNotifications(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    isNotificationsEnabled = !isNotificationsEnabled;
    await prefs.setString(
        'notifications', isNotificationsEnabled ? 'true' : 'false');
    emitUpdate();
  }

  void toggleLanguage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    isEnglish = !isEnglish;
    await prefs.setString('locale', isEnglish ? 'true' : 'false');
    context.setLocale(
        isEnglish ? const Locale('en', 'US') : const Locale('ar', 'SA'));
    emitUpdate();
  }

  void toggleDarkMode(BuildContext context) {
    isDarkMode = !isDarkMode;
    final themeCubit = context.read<AppThemeCubit>();
    themeCubit.changeTheme(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    emitUpdate();
  }

  navigateToAddEvent(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => AddEventScreen()));

  navigateToHome(BuildContext context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));

  logout(BuildContext context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));

  emitUpdate() => emit(UpdateUIState());
}
