import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/model/rating/company_rating_question.dart';
import 'package:q_flow_organizer/model/user/visitor.dart';
import 'package:q_flow_organizer/reusable_components/animated_snack_bar.dart';
import 'package:q_flow_organizer/screens/companies/companies_screen.dart';
import 'package:q_flow_organizer/screens/company_rating/company_rating_screen.dart';
import 'package:q_flow_organizer/screens/home/network_functions.dart';
import 'package:q_flow_organizer/screens/interviews/interviews_screen.dart';
import 'package:q_flow_organizer/screens/most_applied/most_applied_screen.dart';
import 'package:q_flow_organizer/screens/top_majors/top_majors_screen.dart';
import 'package:q_flow_organizer/screens/visitor_rating/visitor_rating_screen.dart';
import '../../model/event/event.dart';
import '../../model/event/event_invited_user.dart';
import '../../model/user/company.dart';
import '../add_event/add_event_screen.dart';
import '../visitors/visitors_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeState? previousState;

  HomeCubit() : super(HomeInitial()) {
    initialLoad();
  }
  List<Company> companies = [];
  List<Visitor> visitors = [];
  final List<CompanyRatingQuestion> questions = [];
  List<EventInvitedUser> invitedVisitors = [];
  List<EventInvitedUser> invitedCompanies = [];

  int numCompanies = 0;
  int numVisitors = 0;
  int numInterviews = 0;
  int totalInvitedVisitors = 1;
  int totalInvitedCompanies = 1;
  List<Company> scannedCompanies = [];
  List<Visitor> scannedVisitors = [];

  Set<String> scannedIds = {};

  initialLoad() async {
    await fetchCompanies();
    await TotalNumOfInterviews();
    await fetchVisitors();
    var invitedUsers = await fetchInvitedUsers();
    invitedVisitors =
        invitedUsers.where((user) => user.isCompany == false).toList();
    totalInvitedVisitors = invitedVisitors.length;
    invitedCompanies =
        invitedUsers.where((user) => user.isCompany == true).toList();
    totalInvitedCompanies = invitedCompanies.length;

    numCompanies = invitedCompanies.where((c) => c.companyId != null).length;
    numVisitors = invitedVisitors.where((c) => c.visitorId != null).length;
  }

  Future scanQR(BuildContext context) async {
    String scan;
    try {
      scan = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', false, ScanMode.QR);
      if (scan == '-1') return;
      print("Scanned QR Code: $scan");
      if (scannedIds.contains(scan)) {
        showSnackBar(context, "This ID has already been scanned.",
            AnimatedSnackBarType.warning);
        return; // Exit if already scanned
      }

      bool isVisitor = visitors.any((visitor) => visitor.id == scan);
      bool isCompany = companies.any((company) => company.id == scan);

      if (isVisitor) {
        if (invitedVisitors.any((v) => v.visitorId == scan)) {
          showSnackBar(context, "This Visitor ID has already been counted.",
              AnimatedSnackBarType.error);
        } else {
          Visitor visitor =
              visitors.firstWhere((visitor) => visitor.id == scan);
          scannedVisitors.add(visitor);

          var user = invitedVisitors
              .where((v) => v.email == visitor.email)
              .toList()
              .firstOrNull;

          if (user == null) throw Exception();

          user.visitorId = visitor.id;

          await setScannedQR(user);

          showSnackBar(context, "Visitor ID recognized successfully!",
              AnimatedSnackBarType.success);
          numVisitors++;
          scannedIds.add(scan); // Add to scanned IDs
        }
      } else if (isCompany) {
        if (invitedCompanies.any((v) => v.companyId == scan)) {
          showSnackBar(context, "This Company ID has already been counted.",
              AnimatedSnackBarType.error);
        } else {
          Company company =
              companies.firstWhere((company) => company.id == scan);
          scannedCompanies.add(company);

          var user = invitedCompanies
              .where((v) => v.email == company.email)
              .toList()
              .firstOrNull;

          if (user == null) throw Exception();

          user.companyId = company.id;

          await setScannedQR(user);

          showSnackBar(context, "Company ID recognized successfully!",
              AnimatedSnackBarType.success);
          numCompanies++;
          scannedIds.add(scan); // Add to scanned IDs
        }
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
          builder: (context) =>
              AddEventScreen(event: event, isInitialSetup: false)));

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

  navigateToCompanies(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CompaniesScreen(
              invitedCompanies: invitedCompanies, allCompanies: companies)));

  navigateToVisitors(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VisitorsScreen(
              invitedVisitors: invitedVisitors, allVisitors: visitors)));

  navigateToInterviews(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => InterviewsScreen()));

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }

  navigateBack(BuildContext context) => Navigator.of(context).pop();

  @override
  void emit(HomeState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitUpdate() => emit(UpdateUIState());
  emitLoading() => emit(LoadingState());
  emitError(msg) => emit(ErrorState(msg));
}
