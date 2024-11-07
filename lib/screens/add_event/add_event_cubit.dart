import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:q_flow_organizer/extensions/date_ext.dart';
import 'package:q_flow_organizer/model/event/event_invited_user.dart';
import 'package:q_flow_organizer/reusable_components/animated_snack_bar.dart';
import 'package:q_flow_organizer/utils/excel_util.dart';
import 'package:uuid/uuid.dart';

import '../../model/event/event.dart';

part 'add_event_state.dart';

class AddEventCubit extends Cubit<AddEventState> {
  AddEventState? previousState;
  AddEventCubit(Event? event) : super(AddEventInitial()) {
    initialLoad(event);
  }

  var eventId = Uuid().v4().toString();

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  File? imgUrl;
  File? companiesFile;
  File? usersFile;

  List<EventInvitedUser> eventInvitedUsers = [];

  initialLoad(Event? event) {
    if (event?.id != null) {
      eventId = event!.id!;
    }
    nameController.text = event?.name ?? '';
    locationController.text = event?.location ?? '';
    if (event?.startDate != null) {
      startDate = event!.startDate!.toDate();
    }
    if (event?.endDate != null) {
      endDate = event!.endDate!.toDate();
    }
  }

  bool validateFields() {
    final currentDate = DateTime.now();
    if (nameController.text.isEmpty ||
        locationController.text.isEmpty ||
        startDate.isBefore(currentDate) ||
        // companiesFile == null ||
        // usersFile == null ||
        endDate.isBefore(startDate)) {
      return false;
    }
    return true;
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

  uploadCompanyFile() async {
    var companiesArr = await ExcelUtil.importExcel();
    for (var company in companiesArr) {
      var item = EventInvitedUser(
          eventId: eventId,
          name: company.$1,
          email: company.$2,
          isCompany: true);
      eventInvitedUsers.add(item);
    }
    emitUpdate();
  }

  uploadVisitorsFile() async {
    var visitorsArr = await ExcelUtil.importExcel();
    for (var visitor in visitorsArr) {
      var item = EventInvitedUser(
          eventId: eventId,
          name: visitor.$1,
          email: visitor.$2,
          isCompany: false);
      eventInvitedUsers.add(item);
    }
    emitUpdate();
  }

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }

  @override
  void emit(AddEventState state) {
    previousState = this.state;
    super.emit(state);
  }

  void emitLoading() => emit(LoadingState());
  void emitUpdate() => emit(UpdateUIState());
  void emitError(String msg) => emit(ErrorState(msg));
}
