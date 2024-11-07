import 'dart:io';

import 'package:q_flow_organizer/model/event/event.dart';
import 'package:q_flow_organizer/model/event/event_invited_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/img_converter.dart';
import 'client/supabase_mgr.dart';

class SupabaseEvent {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String eventTableKey = 'event';
  static final String invitationTableKey = 'event_invited_user';
  static final String bucketKey = 'event_logo';

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
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException {
      rethrow;
    } catch (e) {
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
    } on PostgrestException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future inviteUsers(List<EventInvitedUser> companies) async {
    try {
      var usersData = companies.map((company) => company.toJson()).toList();
      var response =
          await supabase.from(invitationTableKey).insert(usersData).select();
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<EventInvitedUser>> fetchInvitedUsers() async {
    try {
      var res = await supabase.from(invitationTableKey).select();
      List<EventInvitedUser> users = (res as List)
          .map((visitor) =>
              EventInvitedUser.fromJson(visitor as Map<String, dynamic>))
          .toList();
      return users;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future setScannedQR(EventInvitedUser user) async {
    if (user.id == null) {
      throw ArgumentError('User ID cannot be null');
    }

    try {
      final response = await supabase
          .from(invitationTableKey)
          .update(user.toJson())
          .eq('id', user.id!)
          .select()
          .maybeSingle();
      return response;
    } on AuthException {
      rethrow;
    } on PostgrestException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
