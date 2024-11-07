import 'package:q_flow_organizer/model/event/event_invited_user.dart';
import 'package:q_flow_organizer/screens/home/home_cubit.dart';
import 'package:q_flow_organizer/supabase/supabase_company.dart';
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

  Future fetchInvitedUsers() async {
    try {
      final res = await SupabaseEvent.fetchInvitedUsers();
      emitUpdate();
      return (res);
    } catch (e) {
      emitError('Error fetching invited users');
    }
  }

  Future setScannedQR(EventInvitedUser user) async {
    try {
      emitLoading();
      await SupabaseEvent.setScannedQR(user);
      emitUpdate();
    } catch (_) {
      rethrow;
    }
  }

// Interviews

  Future<void> TotalNumOfInterviews() async {
    try {
      final res = await SupabaseInterview.fetchCompletedInterviewIds();
      numInterviews = res.length;
      emitUpdate();
    } catch (e) {
      print('Error fetching interviews: ${e.toString()}');
    }
  }
}
