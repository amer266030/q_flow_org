import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/managers/data_mgr.dart';
import 'package:q_flow_organizer/model/rating/company_rating_question.dart';
import 'package:q_flow_organizer/model/user/visitor.dart';
import 'package:q_flow_organizer/reusable_components/animated_snack_bar.dart';
import 'package:q_flow_organizer/screens/company_rating/company_rating_screen.dart';
import 'package:q_flow_organizer/screens/most_applied/most_applied_screen.dart';
import 'package:q_flow_organizer/screens/top_majors/top_majors_screen.dart';
import 'package:q_flow_organizer/screens/visitor_rating/visitor_rating_screen.dart';
import '../../model/event/event.dart';
import '../../model/user/company.dart';
import '../add_event/add_event_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    initialLoad();
  }
  List<Company> companies = [];
  List<Visitor> visitors = [];
  final List<CompanyRatingQuestion> questions = [];
  late DataMgr dataMgr;

  initialLoad() {
    dataMgr = DataMgr();
  }

  Future scanQR(BuildContext context) async {
    String scan;
    try {
      scan = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', false, ScanMode.QR);
      if (scan == '-1') return;
      print("Scanned QR Code: $scan");
      await dataMgr.fetchData();
      bool isVisitor = dataMgr.visitors.any((visitor) => visitor.id == scan);
      bool isCompany = dataMgr.companies.any((company) => company.id == scan);
      if (isVisitor) {
        showSnackBar(context, "Visitor ID recognized successfully!",
            AnimatedSnackBarType.success);
      } else if (isCompany) {
        showSnackBar(context, "Company ID recognized successfully!",
            AnimatedSnackBarType.success);
      } else {
        showSnackBar(context, "ID does not match any visitor or company.",
            AnimatedSnackBarType.error);
      }
    } on PlatformException {
      scan = 'Failed to get platform version.';
    } catch (e) {
      showSnackBar(
          context, "Error scanning QR Code.", AnimatedSnackBarType.error);
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

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }

  navigateBack(BuildContext context) => Navigator.of(context).pop();

  emitUpdate() => emit(UpdateUIState());
}
