import 'package:q_flow_organizer/screens/home/home_cubit.dart';
import 'package:q_flow_organizer/supabase/subapase_company.dart';
import 'package:q_flow_organizer/supabase/supabase_event.dart';
import 'package:q_flow_organizer/supabase/supabase_interview.dart';
import 'package:q_flow_organizer/supabase/supabase_visitor.dart';

extension NetworkFunctions on HomeCubit {
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

  Future<void> fetchVisitors() async {
    try {
      final res = await SupabaseVisitor.fetchVisitors();
      visitors = res ?? [];
       emitUpdate();
      print('Fetched visitors: ${visitors.length}');
    } catch (e) {
      print('Error fetching visitors: ${e.toString()}');
    }
  }

  Future<void> fetchInvitedVisitors() async {
    try {
      final res = await SupabaseEvent
          .fetchInvitedVisitors(); // This should fetch invited visitors
      invitedVisitors = res ?? [];
      totalInvitedVisitors = invitedVisitors.length; // Update total count
       emitUpdate();
      print('Total invited visitors: $totalInvitedVisitors');
    } catch (e) {
      print('Error fetching invited visitors: ${e.toString()}');
    }
  }
// Interviews

  Future<void> TotalNumOfInterviews() async {
    try {
      final res = await SupabaseInterview.fetchCompletedInterviewIds();
      if (res != null) {
        numInterviews = res.length; // Update the number of interviews
        emitUpdate();
      }
    } catch (e) {
      print('Error fetching interviews: ${e.toString()}');
    }
  }
}
