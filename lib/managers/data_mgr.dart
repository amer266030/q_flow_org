import 'package:q_flow_organizer/model/user/visitor.dart';
import 'package:q_flow_organizer/supabase/subapase_company.dart';

import '../model/user/company.dart';
import '../supabase/supabase_visitor.dart';

class DataMgr {
  List<Visitor> visitors = [];
  List<Company> companies = [];

  DataMgr() {
     fetchData();
  }

  fetchData() async {
    await fetchCompanies();
    await fetchVisitorsData();
  }
  // Company Functions

  Future<void> fetchCompanies() async {
    try {
      final res = await SupabaseCompany.fetchCompanies();
     companies = res ?? [];
      print('Fetched companies: ${companies.length}');
    } catch (e) {
       print('Error fetching companies: ${e.toString()}');
    }
  }

  Future<void> fetchVisitorsData() async {
    try {
     final res = await SupabaseVisitor.fetchVisitors();
      visitors = res ?? [];
      print('Fetched visitors: ${visitors.length}');
    } catch (e) {
      print('Error fetching visitors: ${e.toString()}');
    }
  }
}
