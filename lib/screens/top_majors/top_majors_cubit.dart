import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'top_majors_state.dart';

class TopMajorsCubit extends Cubit<TopMajorsState> {
  TopMajorsCubit() : super(TopMajorsInitial());
  final ValueNotifier<int> touchedIndex = ValueNotifier<int>(-1);
  void updateTouchedIndex(int index) {
    touchedIndex.value = index; // Update the touched index
    emitUpdate(); // Emit updated state
  }

  emitUpdate() => emit(UpdateUIState());
}
