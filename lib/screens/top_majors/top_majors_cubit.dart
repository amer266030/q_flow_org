import 'package:bloc/bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:q_flow_organizer/screens/top_majors/network_functions.dart';

part 'top_majors_state.dart';

class TopMajorsCubit extends Cubit<TopMajorsState> {
  TopMajorsState? previousState;

  TopMajorsCubit() : super(TopMajorsInitial()) {
    initialLoad();
  }
  Map<String, int> skillValues = {};
  final ValueNotifier<int> touchedIndex = ValueNotifier<int>(-1);
  final ValueNotifier<String?> touchedSkill = ValueNotifier("");
  PieTouchResponse? lastTouchResponse;

  initialLoad() async {
    emitLoading();
    fetchTopSkillIds();
    emitUpdate();
  }

  void updateTouchedIndex(int index) {
    touchedIndex.value = index; // Update the touched index
    emitUpdate(); // Emit updated state
  }

  void updateTouchedSkill(String skill) {
    touchedSkill.value = skill;
  }

  void updateLastTouchResponse(PieTouchResponse? response) {
    lastTouchResponse = response;
    emitUpdate();
  }

  @override
  void emit(TopMajorsState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitUpdate() => emit(UpdateUIState());
  emitLoading() => emit(LoadingState());
  emitError(msg) => emit(ErrorState(msg));
}
