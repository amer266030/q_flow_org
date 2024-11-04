import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:q_flow_organizer/model/interview.dart';
import 'package:q_flow_organizer/model/user/company.dart';
import 'package:q_flow_organizer/screens/most_applied/network_functions.dart';
import 'package:q_flow_organizer/supabase/supabase_interview.dart';

part 'most_applied_state.dart';

class MostAppliedCubit extends Cubit<MostAppliedState> {
  MostAppliedState? previousState;
  MostAppliedCubit() : super(MostAppliedInitial()) {
    initialLoad();
  }
  List<Map<String, dynamic>> companies = []; 
  int touchedGroupIndex = -1;
  initialLoad() async {
    emitLoading();
    await fetchInterviewCounts();
  }

 Future<void> fetchInterviewCounts() async {
    try {
      List<Map<String, dynamic>> interviewCounts = await SupabaseInterview.fetchInterviewCountsByCompanies();
      companies = interviewCounts; // Now holds the company names and counts
      emitUpdate();
    } catch (error) {
      emitError(error.toString());
    }
  }

  void updateTouchedGroupIndex(int index) {
    touchedGroupIndex = index;
    emitUpdate();
  }

  @override
  void emit(MostAppliedState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitUpdate() => emit(UpdateUIState());
  emitLoading() => emit(LoadingState());
  emitError(msg) => emit(ErrorState(msg));
}
