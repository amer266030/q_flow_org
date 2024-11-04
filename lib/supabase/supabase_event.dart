import 'dart:io';

import 'package:q_flow_organizer/model/event/event.dart';
import 'package:q_flow_organizer/model/event/event_invited_visitor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/event/event_invited_company_email.dart';
import '../model/event/event_invited_visitor_email.dart';
import '../utils/img_converter.dart';
import 'client/supabase_mgr.dart';

class SupabaseEvent {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String eventTableKey = 'event';
  static final String companyTableKey = 'event_invited_company_email';
  static final String visitorTableKey = 'event_invited_visitor_email';
  static final String bucketKey = 'event_logo';

  static Future<List<Event>>? fetchEvents() async {
    try {
      var res = await supabase.from(eventTableKey).select();
      List<Event> events = (res as List)
          .map((event) => Event.fromJson(event as Map<String, dynamic>))
          .toList();
      print(events.length);
      return events;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future createEvent(
      {required Event event, required File? imageFile}) async {
    try {
      if (imageFile != null) {
        event.imgUrl = await uploadImage(imageFile, event.name ?? '1234');
      }
      final response = await supabase
          .from(eventTableKey)
          .insert(event.toJson())
          .select()
          .single();
      print(response);
      return response;
    } on AuthException catch (_) {
      print('AUTH EXCEPTION');
      rethrow;
    } on PostgrestException catch (e) {
      print(e.toString());
      rethrow;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future updateEvent(
      {required Event event,
      required String eventId,
      required File? imageFile}) async {
    try {
      if (imageFile != null) {
        event.imgUrl = await uploadImage(imageFile, event.name ?? '1234');
      }
      final response = await supabase
          .from(eventTableKey)
          .update(event.toJson())
          .eq('id', eventId);
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

  static Future<String?> uploadImage(File imageFile, String itemName) async {
    try {
      final fileBytes = await ImgConverter.fileImgToBytes(imageFile);
      final fileName = '$itemName.png';

      await supabase.storage.from(bucketKey).uploadBinary(fileName, fileBytes,
          fileOptions: FileOptions(upsert: true));

      final publicUrl = supabase.storage.from(bucketKey).getPublicUrl(fileName);

      return publicUrl;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (e) {
      print('Postgrest error: ${e.message}');
      rethrow;
    } catch (e) {
      print('General error: $e');
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

  static Future<List<EventInvitedVisitor>> fetchInvitedVisitors() async {
    try {
      var res = await supabase.from(visitorTableKey).select();
      List<EventInvitedVisitor> visitors = (res as List)
          .map((visitor) =>
              EventInvitedVisitor.fromJson(visitor as Map<String, dynamic>))
          .toList();
      print(visitors.length);
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
