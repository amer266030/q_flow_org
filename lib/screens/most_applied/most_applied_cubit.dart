import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:q_flow_organizer/screens/most_applied/network_functions.dart';

part 'most_applied_state.dart';

class MostAppliedCubit extends Cubit<MostAppliedState> {
  MostAppliedState? previousState;
  MostAppliedCubit() : super(MostAppliedInitial()) {
    initialLoad();
  }
  List<Map<String, dynamic>> companies = [];
  int touchedGroupIndex = -1;
  initialLoad() async {
    emitLoading();
    await fetchInterviewCounts();
    emitUpdate();
  }

  void updateTouchedGroupIndex(int index) {
    touchedGroupIndex = index;
    emitUpdate();
  }

  @override
  void emit(MostAppliedState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitUpdate() => emit(UpdateUIState());
  emitLoading() => emit(LoadingState());
  emitError(msg) => emit(ErrorState(msg));
}
