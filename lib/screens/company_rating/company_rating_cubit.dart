import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:q_flow_organizer/model/rating/company_rating_question.dart';
import 'package:q_flow_organizer/screens/company_rating/network_function.dart';

part 'company_rating_state.dart';

class CompanyRatingCubit extends Cubit<CompanyRatingState> {
  CompanyRatingCubit() : super(CompanyRatingInitial()) {
    initialLoad();
  }

  CompanyRatingState? previousState;

  Map<String, double> questionAvgRatings = {};
  List<CompanyRatingQuestion> questions = [];

  int touchedGroupIndex = -1;

  initialLoad() async {
    emitLoading();
    avgRatings();
    fetchRatingQuestions();
    emitUpdate();
  }

  void updateTouchedGroupIndex(int index) {
    touchedGroupIndex = index;
    emitUpdate();
  }

  @override
  void emit(CompanyRatingState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitUpdate() => emit(UpdateUIState());
  emitLoading() => emit(LoadingState());
  emitError(msg) => emit(ErrorState(msg));
}
