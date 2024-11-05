import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_flow_organizer/model/user/company.dart';
import 'package:q_flow_organizer/reusable_components/cards/company_card.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({super.key, required this.companies});
  final List<Company> companies;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Attended Companies',
                style: TextStyle(
                  fontSize: context.bodyLarge.fontSize,
                  fontWeight: FontWeight.bold,
                  color: context.textColor1,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: companies.isEmpty
                    ? const Center(child: Text('No companies Attended yet.'))
                    : ListView.builder(
                        itemCount: companies.length,
                        itemBuilder: (context, index) {
                          final company = companies[index];
                          return CompanyCard(
                              company:
                                  company); // Assuming CompanyCard is a widget
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
