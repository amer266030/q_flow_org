import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/enums/attendance.dart';
import '../../model/event/event_invited_user.dart';
import '../../model/user/visitor.dart';

part 'visitors_state.dart';

class VisitorsCubit extends Cubit<VisitorsState> {
  VisitorsCubit(
      List<EventInvitedUser> invitedVisitors, List<Visitor> allVisitors)
      : super(VisitorsInitial()) {
    initialLoad(invitedVisitors, allVisitors);
  }

  VisitorsState? previousState;
  List<EventInvitedUser> invitedVisitors = [];
  List<Visitor> allVisitors = [];
  List<Visitor> attended = [];
  List<Visitor> didNotAttend = [];
  List<Visitor> filteredVisitors = [];
  var selectedStatus = Attendance.attended;

  initialLoad(
      List<EventInvitedUser> invitedVisitors, List<Visitor> allVisitors) async {
    emitLoading();
    this.invitedVisitors = invitedVisitors;
    this.allVisitors = allVisitors;
    createVisitorSegments();
    filterVisitors();
    emitUpdate();
  }

  setSelectedStatus(int idx) {
    selectedStatus = Attendance.values[idx];
    filterVisitors();
    emitUpdate();
  }

  filterVisitors() {
    filteredVisitors =
        selectedStatus == Attendance.attended ? attended : didNotAttend;
  }

  createVisitorSegments() {
    var attendedVisitorIds = invitedVisitors
        .where((c) => c.visitorId != null)
        .map((c) => c.visitorId)
        .toList();

    attended =
        allVisitors.where((c) => attendedVisitorIds.contains(c.id)).toList();
    didNotAttend =
        allVisitors.where((c) => !attendedVisitorIds.contains(c.id)).toList();
  }

  @override
  void emit(VisitorsState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitUpdate() => emit(UpdateUIState());
  emitLoading() => emit(LoadingState());
  emitError(msg) => emit(ErrorState(msg));
}
