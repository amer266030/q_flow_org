import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:q_flow_organizer/model/user/visitor.dart';
import 'package:q_flow_organizer/reusable_components/cards/visitor_card.dart';

import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class VisitorsScreen extends StatelessWidget {
  const VisitorsScreen({super.key, required this.visitors});
  final List<Visitor> visitors;
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
                'Attended Visitors',
                style: TextStyle(
                  fontSize: context.bodyLarge.fontSize,
                  fontWeight: FontWeight.bold,
                  color: context.textColor1,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: visitors.isEmpty
                    ? const Center(child: Text('No Visitors Attended yet.'))
                    : ListView.builder(
                        itemCount: visitors.length,
                        itemBuilder: (context, index) {
                          final visitor = visitors[index];
                          return VisitorCard(
                              visitor:
                                  visitor); // Assuming CompanyCard is a widget
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
