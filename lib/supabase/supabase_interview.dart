import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/interview.dart';
import 'client/supabase_mgr.dart';

class SupabaseInterview {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'interview';
  static final String companyTable = 'company';

  static Future<List<Map<String, dynamic>>>
      fetchInterviewCountsByCompanies() async {
    // Step 1: Fetch all interviews
    final response = await supabase.from(tableKey).select('company_id');

    // Check if the response contains data
    if (response is List) {
      // Step 2: Count interviews per company
      Map<String, int> companyInterviewCounts = {};

      for (var interview in response) {
        String companyId = interview['company_id'] as String;
        companyInterviewCounts[companyId] =
            (companyInterviewCounts[companyId] ?? 0) + 1;
      }

      // Step 3: Fetch company details for each company_id
      List<Map<String, dynamic>> interviewCounts = [];
      for (var entry in companyInterviewCounts.entries) {
        String companyId = entry.key;
        int count = entry.value;

        final companyResponse = await supabase
            .from(companyTable)
            .select('name')
            .eq('id', companyId)
            .single();

        if (companyResponse != null) {
          interviewCounts.add({
            'companyName': companyResponse['name'],
            'interviewCount': count,
          });
        }
      }

      return interviewCounts;
    } else {
      // Return an empty list if no interviews found
      return [];
    }
  }

  static Future<List<String>> fetchCompletedInterviewIds() async {
    final response = await SupabaseMgr.shared.supabase
        .from(tableKey)
        .select('id')
        .eq('status', 'Completed');

    return (response as List)
        .map((interview) => interview['id'] as String)
        .toList();
  }
}
