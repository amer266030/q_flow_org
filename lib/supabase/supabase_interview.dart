import 'dart:async';

import 'package:q_flow_organizer/model/user/company.dart';
import 'package:q_flow_organizer/model/user/visitor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/interview.dart';
import 'client/supabase_mgr.dart';

class SupabaseInterview {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'interview';
  static final String companyTable = 'company';
  static const String visitorTable = 'visitor';

  static Future<List<Map<String, dynamic>>>
      fetchInterviewCountsByCompanies() async {
    final response = await supabase.from(tableKey).select('company_id');

    if (response is List) {
      Map<String, int> companyInterviewCounts = {};

      for (var interview in response) {
        String companyId = interview['company_id'] as String;
        companyInterviewCounts[companyId] =
            (companyInterviewCounts[companyId] ?? 0) + 1;
      }

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

  static Future<List<Map<String, dynamic>>>
      fetchCompletedInterviewDetails() async {
    final completedInterviewIds = await fetchCompletedInterviewIds();
    List<Map<String, dynamic>> interviewDetails = [];

    print("Completed Interview IDs: $completedInterviewIds");

    for (var interviewId in completedInterviewIds) {
      final interviewResponse = await supabase
          .from(tableKey)
          .select('visitor_id, company_id')
          .eq('id', interviewId)
          .single();

      if (interviewResponse != null) {
        String visitorId = interviewResponse['visitor_id'] as String;
        String companyId = interviewResponse['company_id'] as String;

        // Fetch company details (name, logo URL)
        final companyResponse = await supabase
            .from(companyTable)
            .select(
                'name, logo_url') // Removed social_links from the select statement
            .eq('id', companyId)
            .single();

        // Fetch visitor details (name, avatar URL, and ID)
        final visitorResponse = await supabase
            .from(visitorTable)
            .select('f_name, l_name, avatar_url ')
            .eq('id', visitorId)
            .single();

        print("Fetched Company: $companyResponse");
        print("Fetched Visitor: $visitorResponse");

        // If both company and visitor data are available, add them to the result list
        if (companyResponse != null && visitorResponse != null) {
          final company = Company.fromJson(companyResponse);
          final visitor = Visitor.fromJson(visitorResponse);

          interviewDetails.add({
            'interviewId': interviewId,
            'company': company,
            'visitor': visitor,
          });
        }
      }
    }

    print("Combined Interview Details: $interviewDetails");
    return interviewDetails;
  }
}
