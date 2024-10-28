import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:q_flow_organizer/screens/add_event/add_event_screen.dart';
import 'package:q_flow_organizer/screens/auth/auth_screen.dart';
import 'package:q_flow_organizer/screens/events/events_screen.dart';
import 'package:q_flow_organizer/screens/home/home_screen.dart';
import 'package:q_flow_organizer/supabase/client/supabase_mgr.dart';
import 'package:q_flow_organizer/theme_data/app_theme_cubit.dart';
import 'package:q_flow_organizer/theme_data/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SupabaseMgr.shared.initialize();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppThemeCubit(),
      child: BlocBuilder<AppThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: themeMode,
              locale: context.locale, // From EasyLocalization
              supportedLocales:
                  context.supportedLocales, // From EasyLocalization
              localizationsDelegates:
                  context.localizationDelegates, // From EasyLocalization
              home: AddEventScreen());
        },
      ),
    );
  }
}
