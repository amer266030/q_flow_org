import 'package:q_flow_organizer/screens/visitor_rating/visitor_rating_cubit.dart';
import 'package:q_flow_organizer/supabase/supabase_visitor_rating.dart';

extension NetworkFunctions on VisitorRatingCubit {
  Future<void> avgRatings() async {
    questionAvgRatings =
        await SupabaseVisitorRating.fetchAvgRatings(); // Fetch all averages at once
    print('Number of average ratings: ${questionAvgRatings.length}');
    emitUpdate();
  }

  // Rating Questions
  Future<void> fetchRatingQuestions() async {
    try {
      questions = await SupabaseVisitorRating.fetchQuestions() ?? [];
      emitUpdate();
    } catch (e) {
      rethrow;
    }
  }

}
