import 'package:flutter/material.dart';
import 'package:q_flow_organizer/extensions/date_ext.dart';
import 'package:q_flow_organizer/screens/add_event/add_event_cubit.dart';
import 'package:q_flow_organizer/supabase/client/supabase_mgr.dart';

import '../../model/event/event.dart';
import '../../supabase/supabase_event.dart';

extension NetworkFunctions on AddEventCubit {
  createEvent(BuildContext context) async {
    print(SupabaseMgr.shared.supabase.auth.currentUser?.id ?? '');
    var event = Event(
      organizerId: SupabaseMgr.shared.supabase.auth.currentUser?.id ?? '',
      name: nameController.text,
      location: locationController.text,
      startDate: startDate.toFormattedString(),
      endDate: endDate.toFormattedString(),
    );
    print(event);
    try {
      emitLoading();
      await SupabaseEvent.createEvent(event: event, imageFile: imgUrl);
      await Future.delayed(Duration(microseconds: 50));
      Navigator.of(context).pop();
    } catch (e) {
      emitError('Could not create event!\nPlease try again later.');
    }
  }
}
