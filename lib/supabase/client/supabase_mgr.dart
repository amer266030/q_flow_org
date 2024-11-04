import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMgr {
  late final SupabaseClient supabase;

  SupabaseMgr._privateConstructor();

  static final SupabaseMgr _instance = SupabaseMgr._privateConstructor();

  static SupabaseMgr get shared => _instance;

  Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
    supabase = await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    ).then((value) => value.client);
  }
  
}
