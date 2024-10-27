import 'package:q_flow_organizer/model/event/event.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/event/event_invited_company_email.dart';
import '../model/event/event_invited_visitor_email.dart';
import 'client/supabase_mgr.dart';

class SupabaseEvent {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String eventTableKey = 'event';
  static final String companyTableKey = 'event_invited_company_email';
  static final String visitorTableKey = 'event_invited_visitor_email';

  static Future<List<Event>>? fetchEvents() async {
    try {
      var res = await supabase.from(eventTableKey).select();
      List<Event> events = (res as List)
          .map((event) => Event.fromJson(event as Map<String, dynamic>))
          .toList();
      return events;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future createEvent(Event event) async {
    try {
      final response = await supabase
          .from(eventTableKey)
          .insert(event.toJson())
          .select()
          .single();
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future updateEvent(Event event) async {
    try {
      final response = await supabase
          .from(eventTableKey)
          .update(event.toJson())
          .eq('id', event.id ?? '');
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future deleteEvent(Event event) async {
    if (event.id == null) {
      throw Exception('Could not find records of this event');
    }
    try {
      await supabase.from(eventTableKey).delete().eq('id', event.id!);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future inviteCompanies(
      List<EventInvitedCompanyEmail> companies) async {
    try {
      var companyData = companies.map((company) => company.toJson()).toList();
      var response =
          await supabase.from(companyTableKey).insert(companyData).select();
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future inviteVisitors(List<EventInvitedVisitorEmail> visitors) async {
    try {
      var visitorData = visitors.map((company) => company.toJson()).toList();
      var response =
          await supabase.from(visitorTableKey).insert(visitorData).select();
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
