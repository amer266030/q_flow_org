import 'package:q_flow_organizer/model/skills/skill.dart';
import 'package:q_flow_organizer/supabase/client/supabase_mgr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSkill {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static const String tableKey = 'skill';
  static Future<List<Map<String, dynamic>>> getTopSkillIdsAllCompanies() async {
    try {
      // Step 1: Fetch all skills
      final response = await supabase.from(tableKey).select('tech_skill');

      // Step 2: Count occurrences of each skill
      final skillsData = List<Map<String, dynamic>>.from(response);
      final skillCountMap = <String, int>{};

      for (var skill in skillsData) {
        final techSkill = skill['tech_skill'];
        if (techSkill != null) {
          skillCountMap[techSkill] = (skillCountMap[techSkill] ?? 0) + 1;
        }
      }

      // Step 3: Sort and get the top 5 skill IDs
      final topSkills = skillCountMap.entries.toList()
        ..sort(
            (a, b) => b.value.compareTo(a.value)); // Sort by count descending

      // Return only the top 5 skill IDs with their counts
      final topFiveSkills = topSkills
          .take(5)
          .map((entry) => {
                'tech_skill': entry.key,
                'count': entry.value,
              })
          .toList();
      return topFiveSkills;
    } catch (e) {
      rethrow;
    }
  }
}
