import 'package:q_flow_organizer/screens/companies/companies_cubit.dart';
import 'package:q_flow_organizer/supabase/subapase_company.dart';

extension NetworkFunctions on CompaniesCubit {
  Future<void> loadCompanies() async {
    try {
      final fetchedCompanies = await SupabaseCompany.fetchCompanies();
      if (fetchedCompanies != null && fetchedCompanies.isNotEmpty) {
        companies = fetchedCompanies;
        print("Companies loaded: $companies"); // Debugging log
        emitUpdate();
      } else {
        emitError('No companies found.');
      }
    } catch (e) {
      emitError('Error fetching companies: $e');
    }
  }
}
