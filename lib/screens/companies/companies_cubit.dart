import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:q_flow_organizer/model/user/company.dart';
import 'package:q_flow_organizer/screens/companies/network_functions.dart';
import 'package:q_flow_organizer/screens/company_rating/company_rating_cubit.dart';
import 'package:q_flow_organizer/supabase/subapase_company.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit() : super(CompaniesInitial()) {
    initialLoad();
  }
  CompaniesState? previousState;
  List<Company>? companies;

  initialLoad() async {
    emitLoading();

    await loadCompanies();
    emitUpdate();
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
