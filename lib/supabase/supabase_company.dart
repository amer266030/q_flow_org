import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/user/company.dart';
import 'client/supabase_mgr.dart';

class SupabaseCompany {
  static var supabase = SupabaseMgr.shared.supabase;
  static const String tableKey = 'company';

  static Future<List<Company>>? fetchCompanies() async {
    try {
      final response = await supabase.from(tableKey).select();

      final companies = (response as List).map((companyData) {
        final company = Company.fromJson(companyData);

        return company;
      }).toList();

      return companies;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
