import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/model/user/company.dart';
import 'package:q_flow_organizer/reusable_components/buttons/expanded_toggle_buttons.dart';
import 'package:q_flow_organizer/reusable_components/cards/company_card.dart';
import 'package:q_flow_organizer/screens/companies/companies_cubit.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

import '../../model/enums/attendance.dart';
import '../../model/event/event_invited_user.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen(
      {super.key, required this.invitedCompanies, required this.allCompanies});

  final List<EventInvitedUser> invitedCompanies;
  final List<Company> allCompanies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => CompaniesCubit(invitedCompanies, allCompanies),
        child: Builder(builder: (context) {
          final cubit = context.read<CompaniesCubit>();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Companies Presence',
                      style: TextStyle(
                        fontSize: context.bodyLarge.fontSize,
                        fontWeight: FontWeight.bold,
                        color: context.textColor1,
                      ),
                    ),
                  ),
                  BlocBuilder<CompaniesCubit, CompaniesState>(
                    builder: (context, state) {
                      return ExpandedToggleButtons(
                        currentIndex:
                            Attendance.values.indexOf(cubit.selectedStatus),
                        tabs: Attendance.values.map((i) => i.value).toList(),
                        callback: (int value) => cubit.setSelectedStatus(value),
                      );
                    },
                  ),
                  BlocBuilder<CompaniesCubit, CompaniesState>(
                    builder: (context, state) {
                      return Expanded(
                        child: cubit.filteredCompanies.isEmpty
                            ? const Center(child: Text(''))
                            : ListView.builder(
                                itemCount: cubit.filteredCompanies.length,
                                itemBuilder: (context, index) {
                                  final company =
                                      cubit.filteredCompanies[index];
                                  return CompanyCard(company: company);
                                },
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
