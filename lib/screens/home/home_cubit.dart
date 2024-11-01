import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:q_flow_organizer/model/rating/company_rating_question.dart';
import 'package:q_flow_organizer/model/user/visitor.dart';
import 'package:q_flow_organizer/screens/company_rating/company_rating_screen.dart';
import 'package:q_flow_organizer/screens/most_applied/most_applied_screen.dart';
import 'package:q_flow_organizer/screens/top_majors/top_majors_screen.dart';
import 'package:q_flow_organizer/screens/visitor_rating/visitor_rating_screen.dart';

import '../../model/event/event.dart';
import '../../model/user/company.dart';
import '../add_event/add_event_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {}
  List<Company> companies = [];
  List<Visitor> visitors = [];
  final List<CompanyRatingQuestion> questions = [];

  Future scanQR() async {
    String scan;
    try {
      scan = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', false, ScanMode.QR);
      print(scan);
    } on PlatformException {
      scan = 'Failed to get platform version.';
    }
    emitUpdate();
  }

  navigateToEditEvent(BuildContext context, Event event) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEventScreen(event: event)));

  navigateToCompanyRating(
    BuildContext context,
  ) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CompanyRatingScreen(
        questions: questions,
      ),
    ));
  }

  navigateToVisitorRating(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => VisitorRatingScreen()));
  }

  navigateToTopMajors(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TopMajorsScreen()));
  }

  navigateToMostApplied(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MostAppliedScreen()));
  }

  navigateBack(BuildContext context) => Navigator.of(context).pop();

  emitUpdate() => emit(UpdateUIState());
}
