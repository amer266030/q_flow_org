import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_event_state.dart';

class AddEventCubit extends Cubit<AddEventState> {
  AddEventCubit() : super(AddEventInitial());

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  addEventPicture() {
    emitLoading();

    print('add event picture');

    Future.delayed(const Duration(seconds: 2), () {});

    emitUpdate();
  }

  updateStartDate(DateTime date) {
    startDate = date;
    emitUpdate();
  }

  updateEndDate(DateTime date) {
    endDate = date;
    emitUpdate();
  }

  uploadCompanyFile() {
    emitUpdate();
  }

  uploadVisitorsFile() {
    emitLoading();

    emitUpdate();
  }

  createEvent(BuildContext context) {
    Navigator.of(context).pop();
    emitUpdate();
  }

  void emitLoading() => emit(LoadingState());
  void emitUpdate() => emit(UpdateUIState());
}
