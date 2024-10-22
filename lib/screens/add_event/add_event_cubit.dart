import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/event.dart';

part 'add_event_state.dart';

class AddEventCubit extends Cubit<AddEventState> {
  AddEventCubit(Event? event) : super(AddEventInitial()) {
    initialLoad(event);
  }

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  File? imgUrl;
  File? companiesFile;
  File? usersFile;

  initialLoad(Event? event) {
    nameController.text = event?.name ?? '';
    locationController.text = event?.location ?? '';
    if (event?.startDate != null) {
      startDate = DateTime.parse(event!.startDate!);
    }
    if (event?.endDate != null) {
      endDate = DateTime.parse(event!.endDate!);
    }
  }

  void getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) imgUrl = File(img.path);
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
    // Excel Sheet upload
    emitUpdate();
  }

  uploadVisitorsFile() {
    // Excel Sheet upload
    emitUpdate();
  }

  createEvent(BuildContext context) {
    Navigator.of(context).pop();
    emitUpdate();
  }

  void emitLoading() => emit(LoadingState());
  void emitUpdate() => emit(UpdateUIState());
}
