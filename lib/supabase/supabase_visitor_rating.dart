import 'package:q_flow_organizer/model/rating/visitor_rating_question.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'client/supabase_mgr.dart';

class SupabaseVisitorRating {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String ratingTableKey = 'visitor_rating';
  static final String questionRatingTableKey = 'visitor_question_rating';
  static final String questionsTableKey = 'visitor_rating_question';

  static Future<List<VisitorRatingQuestion>>? fetchQuestions() async {
    try {
      var res = await supabase
          .from(questionsTableKey)
          .select()
          .order('sort_order', ascending: true);

      List<VisitorRatingQuestion> questions = (res as List)
          .map((event) =>
              VisitorRatingQuestion.fromJson(event as Map<String, dynamic>))
          .toList();

      return questions;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, double>> fetchAvgRatings() async {
    try {
      // Fetch all ratings at once
      final res = await supabase
          .from(questionRatingTableKey)
          .select('question_id, rating');

      // Group ratings by question ID
      Map<String, List<int>> ratingsMap = {};
      for (var item in res) {
        String questionId = item['question_id'] as String;
        int rating = item['rating'] as int;

        // Initialize list if it doesn't exist
        if (!ratingsMap.containsKey(questionId)) {
          ratingsMap[questionId] = [];
        }
        ratingsMap[questionId]!.add(rating);
      }

      // Calculate average ratings
      Map<String, double> avgRatings = {};
      ratingsMap.forEach((questionId, ratings) {
        if (ratings.isNotEmpty) {
          double avgRating = ratings.reduce((a, b) => a + b) / ratings.length;
          avgRatings[questionId] = avgRating;
        }
      });

      return avgRatings;
    } on PostgrestException catch (e) {
      throw Exception("Failed to fetch average ratings: ${e.message}");
    }
  }
}
