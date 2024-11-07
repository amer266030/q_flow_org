import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/reusable_components/buttons/expanded_toggle_buttons.dart';
import 'package:q_flow_organizer/reusable_components/cards/visitor_card.dart';
import 'package:q_flow_organizer/screens/visitors/visitors_cubit.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

import '../../model/enums/attendance.dart';
import '../../model/event/event_invited_user.dart';
import '../../model/user/visitor.dart';

class VisitorsScreen extends StatelessWidget {
  const VisitorsScreen(
      {super.key, required this.invitedVisitors, required this.allVisitors});

  final List<EventInvitedUser> invitedVisitors;
  final List<Visitor> allVisitors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => VisitorsCubit(invitedVisitors, allVisitors),
        child: Builder(builder: (context) {
          final cubit = context.read<VisitorsCubit>();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Visitor Presence',
                      style: TextStyle(
                        fontSize: context.bodyLarge.fontSize,
                        fontWeight: FontWeight.bold,
                        color: context.textColor1,
                      ),
                    ),
                  ),
                  BlocBuilder<VisitorsCubit, VisitorsState>(
                    builder: (context, state) {
                      return ExpandedToggleButtons(
                        currentIndex:
                            Attendance.values.indexOf(cubit.selectedStatus),
                        tabs: Attendance.values.map((i) => i.value).toList(),
                        callback: (int value) => cubit.setSelectedStatus(value),
                      );
                    },
                  ),
                  BlocBuilder<VisitorsCubit, VisitorsState>(
                    builder: (context, state) {
                      return Expanded(
                        child: cubit.filteredVisitors.isEmpty
                            ? const Center(child: Text(''))
                            : ListView.builder(
                                itemCount: cubit.filteredVisitors.length,
                                itemBuilder: (context, index) {
                                  final visitor = cubit.filteredVisitors[index];
                                  return VisitorCard(visitor: visitor);
                                },
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
