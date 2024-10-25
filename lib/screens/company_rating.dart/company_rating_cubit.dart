import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:q_flow_organizer/model/rating/company_rating_question.dart';
import 'package:q_flow_organizer/model/user/company.dart';

part 'company_rating_state.dart';

class CompanyRatingCubit extends Cubit<CompanyRatingState> {
  CompanyRatingCubit() : super(CompanyRatingInitial()) {
    initialLoad();
  }
  
  List<Company> companies = [];
   List<CompanyRatingQuestion> questions = [];

  int touchedGroupIndex = -1;

  initialLoad() {
    
   questions = List.generate(
      5,
      (index) => CompanyRatingQuestion(
        title: 'Question ${index + 1}', // Assign unique titles
        // You can also add 'text' or other properties if needed
      ),
    );

    emitUpdate();
  }
  void loadQuestions(List<CompanyRatingQuestion> loadedQuestions) {
    questions = loadedQuestions;
    emitUpdate();
  }

  void updateTouchedGroupIndex(int index) {
    touchedGroupIndex = index;
    emitUpdate();
  }

  void loadCompanies(List<Company> companyList) {
    companies = companyList; // Load companies into the cubit
    emitUpdate();
  }

  emitUpdate() => emit(UpdateUIState());
}
