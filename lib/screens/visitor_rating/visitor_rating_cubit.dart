import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:q_flow_organizer/model/rating/visitor_rating_question.dart';
import 'package:q_flow_organizer/screens/visitor_rating/network_function.dart';

part 'visitor_rating_state.dart';

class VisitorRatingCubit extends Cubit<VisitorRatingState> {
  VisitorRatingState? previousState;
  VisitorRatingCubit() : super(VisitorRatingInitial()) {
    initialLoad();
  }

  Map<String, double> questionAvgRatings = {};
  List<VisitorRatingQuestion> questions = [];

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
  void emit(VisitorRatingState state) {
    previousState = this.state;
    super.emit(state);
  }

  emitUpdate() => emit(UpdateUIState());
  emitLoading() => emit(LoadingState());
  emitError(msg) => emit(ErrorState(msg));
}
