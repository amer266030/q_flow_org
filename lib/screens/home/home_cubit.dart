import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/model/enums/company_size.dart';
import 'package:q_flow_organizer/model/enums/reports.dart';
import 'package:q_flow_organizer/model/rating/company_rating_question.dart';
import 'package:q_flow_organizer/model/user/visitor.dart';
import 'package:q_flow_organizer/screens/company_rating.dart/company_rating_screen.dart';
import 'package:q_flow_organizer/screens/visitor_rating.dart/visitor_rating_screen.dart';

import '../../model/user/company.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    initialLoad();
  }
  List<Company> companies = [];
  List<Visitor> visitors = [];
  final List<CompanyRatingQuestion> questions = [];
  Reports selectedStatus = Reports.majors;
  int touchedGroupIndex = -1;
  String? currantSelected = "Company Rating";
  final ValueNotifier<int> touchedIndex = ValueNotifier<int>(-1);

  initialLoad() {
    companies = List.generate(
      5,
      (index) => Company(
        id: '${index + 1}',
        name: 'ABC Company ${index + 1}',
        description: 'ABC Company specializes in providing tech solutions.',
        companySize: CompanySize.oneHundredTo200,
        establishedYear: 2015,
        logoUrl: null,
      ),
    );
    visitors = List.generate(
      5,
      (index) => Visitor(
        id: '${index + 1}',
        fName: 'John ',
        lName: 'Doe ${index + 1}',
      ),
    );

    emitUpdate();
  }

  setSelectedStatus(int idx) {
    selectedStatus = Reports.values[idx];
    emitUpdate();
  }

  void updateTouchedGroupIndex(int index) {
    touchedGroupIndex = index;
    emitUpdate();
  }

  void filterRating(String str) {
    currantSelected = str;
    emitUpdate();
  }

  navigateToCompanyRating(BuildContext context, Company company) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CompanyRatingScreen(
        company: company,
        questions: questions,
      ),
    ));
  }

  navigateToVisitorRating(BuildContext context, Visitor visitor) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => VisitorRatingScreen(
              visitor: visitor,
            )));
  }

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

  navigateBack(BuildContext context) => Navigator.of(context).pop();

  emitUpdate() => emit(UpdateUIState());
}
