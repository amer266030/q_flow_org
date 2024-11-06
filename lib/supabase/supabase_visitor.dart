import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/user/visitor.dart';
import 'client/supabase_mgr.dart';

class SupabaseVisitor {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static const String tableKey = 'visitor';

  static Future<List<Visitor>> fetchVisitors() async {
    try {
      final response = await supabase.from(tableKey).select();

      final visitors = (response as List).map((visitorData) {
        final visitor = Visitor.fromJson(visitorData);

        return visitor;
      }).toList();


      return visitors;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
