import 'package:flutter/material.dart';
import 'package:q_flow_organizer/screens/events/events_cubit.dart';

import '../../supabase/supabase_event.dart';

extension NetworkFunctions on EventsCubit {
  fetchEvents(BuildContext context) async {
    try {
      emitLoading();
      var events = await SupabaseEvent.fetchEvents();
      print(events?.length);
      return events;
    } catch (e) {
      print(e.toString());
      emitError('Could not fetch events!\nPlease try again later.');
    }
  }
}
