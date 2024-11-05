import 'package:q_flow_organizer/screens/company_rating/company_rating_cubit.dart';
import 'package:q_flow_organizer/supabase/supabase_company_rating.dart';

extension NetworkFunctions on CompanyRatingCubit {
  Future<void> avgRatings() async {
    try {
      questionAvgRatings = await SupabaseCompanyRating
          .fetchAvgRatings(); // Fetch all averages at once
      print('Number of average ratings: ${questionAvgRatings.length}');
      emitUpdate();
    } catch (e) {
      rethrow;
    }
  }

  // Rating Questions
  Future<void> fetchRatingQuestions() async {
    try {
      questions = await SupabaseCompanyRating.fetchQuestions() ?? [];
      emitUpdate();
    } catch (e) {
      rethrow;
    }
  }
}
