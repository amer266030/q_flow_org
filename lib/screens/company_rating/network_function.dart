import 'package:q_flow_organizer/screens/company_rating/company_rating_cubit.dart';
import 'package:q_flow_organizer/supabase/supabase_rating.dart';

extension NetworkFunctions on CompanyRatingCubit {
  Future<void> avgRatings() async {
    questionAvgRatings =
        await SupabaseRating.fetchAvgRatings(); // Fetch all averages at once
    print('Number of average ratings: ${questionAvgRatings.length}');
    emitUpdate();
  }

  // Rating Questions
  Future<void> fetchRatingQuestions() async {
    try {
      questions = await SupabaseRating.fetchQuestions() ?? [];
      emitUpdate();
    } catch (e) {
      rethrow;
    }
  }
}
