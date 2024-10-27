import 'package:supabase_flutter/supabase_flutter.dart';

import 'client/supabase_mgr.dart';

class SupabaseAuth {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;

  static Future signIn(String email) async {
    try {
      // Check profile table
      final profileCheck = await supabase
          .from('profile')
          .select('id, role')
          .eq('email', email)
          .single();

      if (profileCheck['role'] != 'organizer') {
        throw Exception(
            "Access denied. User must have an organizer profile to sign in.");
      }
      // Sign-in after check
      var response = await supabase.auth.signInWithOtp(email: email);
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future signOut() async {
    try {
      var response = await supabase.auth.signOut();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
