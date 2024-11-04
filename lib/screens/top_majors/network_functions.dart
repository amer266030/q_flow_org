import 'package:q_flow_organizer/screens/top_majors/top_majors_cubit.dart';
import 'package:q_flow_organizer/supabase/supabase_skill.dart';

extension NetworkFunctions on TopMajorsCubit {
  Future<void>  fetchTopSkillIds() async {
    emitLoading(); // Emit loading state
    try {
      final topSkills = await SupabaseSkill.getTopSkillIdsAllCompanies();
      // Process and store topSkills data here
      skillValues = Map.fromIterable(topSkills, 
        key: (entry) => entry['tech_skill'], 
        value: (entry) => entry['count']);
      
      print('Top Skills: $skillValues');
      emitUpdate(); // Emit updated UI state
    } catch (e) {
      emitError('Failed to load top skills: ${e.toString()}');
    }
  }
}