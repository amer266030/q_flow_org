import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:q_flow_organizer/supabase/supabase_interview.dart';

part 'interviews_state.dart';

class InterviewsCubit extends Cubit<InterviewsState> {
  InterviewsCubit() : super(InterviewsInitial()) {
    initialLoad();
  }
  List<Map<String, dynamic>> interviewDetails = [];

  initialLoad() async {
    emitLoading();
    loadInterviews();
    emitUpdate();
  }

  Future<void> loadInterviews() async {
    try {
      emitUpdate();
      interviewDetails =
          await SupabaseInterview.fetchCompletedInterviewDetails();
      print('Fetched interview details: $interviewDetails');
      emitUpdate();
    } catch (e) {
      print('Error occurred while fetching interview details: $e');
      emitError("Error fetching interview data: ${e.toString()}");
    }
  }

  emitUpdate() => emit(UpdateUIState());
  emitLoading() => emit(LoadingState());
  emitError(msg) => emit(ErrorState(msg));
}
