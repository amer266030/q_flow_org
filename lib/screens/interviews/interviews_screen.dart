import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/extensions/img_ext.dart';
import 'package:q_flow_organizer/model/user/company.dart';
import 'package:q_flow_organizer/model/user/visitor.dart';
import 'package:q_flow_organizer/reusable_components/cards/visitor_card.dart';
import 'package:q_flow_organizer/screens/interviews/interviews_cubit.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class InterviewsScreen extends StatelessWidget {
  const InterviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InterviewsCubit(), // Instantiate the Cubit
      child: Builder(
        builder: (context) {
          final cubit = context.read<InterviewsCubit>();
          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        "Interviews",
                        style: TextStyle(
                          fontSize: context.bodyLarge.fontSize,
                          fontWeight: FontWeight.bold,
                          color: context.textColor1,
                        ),
                      ),
                    ),
                    BlocBuilder<InterviewsCubit, InterviewsState>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is ErrorState) {
                          return Center(child: Text('Error: ${state.msg}'));
                        } else if (state is UpdateUIState) {
                          final combinedData = cubit.interviewDetails;
                          if (combinedData.isEmpty) {
                            return Center(
                                child: Text('No interviews available'));
                          }

                          return Expanded(
                            child: ListView.builder(
                              itemCount: combinedData.length,
                              itemBuilder: (context, index) {
                                var interview = combinedData[index];
                                return InterviewsCard(
                                  company: interview['company'],
                                  visitor: interview['visitor'],
                                );
                              },
                            ),
                          );
                        }

                        return Center(child: Text('Unexpected state'));
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InterviewsCard extends StatelessWidget {
  final Company company;
  final Visitor visitor;

  const InterviewsCard({
    super.key,
    required this.company,
    required this.visitor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.bg2,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.textColor1.withOpacity(0.3),
            blurRadius: 4,
            spreadRadius: 0.5,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Company Logo
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: company.logoUrl != null
                        ? FadeInImage(
                            placeholder: Img.logoOrange,
                            image: NetworkImage(company.logoUrl ?? ''),
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image(
                                  image: Img.logoOrange, fit: BoxFit.cover);
                            },
                          )
                        : Image(image: Img.logoOrange, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            // Company and Visitor Info
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 16),
                    child: Text(
                      company.name ?? 'Unknown Company',
                      style: TextStyle(
                        fontSize: context.bodyMedium.fontSize,
                      ),
                      softWrap: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.compare_arrows_rounded,
                      color: context.primary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 16),
                    child: Text(
                      '${visitor.fName ?? 'Unknown'} ${visitor.lName ?? 'Visitor'}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.bodyMedium.fontSize,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            // Visitor Avatar
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: visitor?.avatarUrl != null &&
                            visitor!.avatarUrl!.isNotEmpty
                        ? FadeInImage(
                            placeholder: Img.logoOrange,
                            image: NetworkImage(visitor!.avatarUrl!),
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return VisitorAvatar();
                            },
                          )
                        : VisitorAvatar(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
