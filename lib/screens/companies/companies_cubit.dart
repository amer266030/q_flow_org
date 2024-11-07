import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:q_flow_organizer/model/enums/attendance.dart';
import 'package:q_flow_organizer/model/user/company.dart';

import '../../model/event/event_invited_user.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit(
      List<EventInvitedUser> invitedCompanies, List<Company> allCompanies)
      : super(CompaniesInitial()) {
    initialLoad(invitedCompanies, allCompanies);
  }
  CompaniesState? previousState;
  List<EventInvitedUser> invitedCompanies = [];
  List<Company> allCompanies = [];
  List<Company> attended = [];
  List<Company> didNotAttend = [];
  List<Company> filteredCompanies = [];
  var selectedStatus = Attendance.attended;

  initialLoad(List<EventInvitedUser> invitedCompanies,
      List<Company> allCompanies) async {
    emitLoading();
    this.invitedCompanies = invitedCompanies;
    this.allCompanies = allCompanies;
    createCompanySegments();
    filterCompanies();
    emitUpdate();
  }

  setSelectedStatus(int idx) {
    selectedStatus = Attendance.values[idx];
    filterCompanies();
    emitUpdate();
  }

  filterCompanies() {
    filteredCompanies =
        selectedStatus == Attendance.attended ? attended : didNotAttend;
  }

  createCompanySegments() {
    var attendedCompanyIds = invitedCompanies
        .where((c) => c.companyId != null)
        .map((c) => c.companyId)
        .toList();

    attended =
        allCompanies.where((c) => attendedCompanyIds.contains(c.id)).toList();
    didNotAttend =
        allCompanies.where((c) => !attendedCompanyIds.contains(c.id)).toList();
  }

  @override
  void emit(CompaniesState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitUpdate() => emit(UpdateUIState());
  emitLoading() => emit(LoadingState());
  emitError(msg) => emit(ErrorState(msg));
}
