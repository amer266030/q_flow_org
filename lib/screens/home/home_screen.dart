import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/model/enums/reports.dart';
import 'package:q_flow_organizer/reusable_components/buttons/expanded_toggle_buttons.dart';
import 'package:q_flow_organizer/screens/home/subviews/report_containtet.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';
import '../../extensions/img_ext.dart';
import 'home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<HomeCubit>();
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  _HeaderView(
                    positionInQueue: null,
                    onBack: () => cubit.navigateBack(context),
                  ),
                  Divider(color: context.bg2),
                  _SectionHeaderView(title: 'Overall Stats'),
                  _StatCardsView(
                    numCompanies: 100,
                    numVisitors: 1000,
                    numInterviews: 2500,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _SectionHeaderView(title: 'Event Reports'),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          ExpandedToggleButtons(
                            currentIndex:
                                Reports.values.indexOf(cubit.selectedStatus),
                            tabs: Reports.values.map((r) => r.value).toList(),
                            callback: (int value) =>
                                cubit.setSelectedStatus(value),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: ReportContent(
                              context: context,
                              cubit: cubit,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}


class _StatCardsView extends StatelessWidget {
  const _StatCardsView({
    super.key,
    required this.numCompanies,
    required this.numVisitors,
    required this.numInterviews,
  });

  final int numCompanies;
  final int numVisitors;
  final int numInterviews;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Text(
                    '$numCompanies',
                    style: TextStyle(
                      fontSize: context.titleSmall.fontSize,
                      fontWeight: FontWeight.bold,
                      color: context.primary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.circle,
                          size: context.bodyLarge.fontSize),
                      SizedBox(width: 4),
                      Text(
                        'Companies',
                        style: TextStyle(
                          fontSize: context.bodySmall.fontSize,
                          color: context.textColor1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Text(
                    '$numVisitors',
                    style: TextStyle(
                      fontSize: context.titleSmall.fontSize,
                      fontWeight: FontWeight.bold,
                      color: context.primary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.circle,
                          size: context.bodyLarge.fontSize),
                      SizedBox(width: 4),
                      Text(
                        'Visitors',
                        style: TextStyle(
                          fontSize: context.bodySmall.fontSize,
                          color: context.textColor1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Text(
                    '$numInterviews',
                    style: TextStyle(
                      fontSize: context.titleSmall.fontSize,
                      fontWeight: FontWeight.bold,
                      color: context.primary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.circle,
                          size: context.bodyLarge.fontSize),
                      SizedBox(width: 4),
                      Text(
                        'Interviews',
                        style: TextStyle(
                          fontSize: context.bodySmall.fontSize,
                          color: context.textColor1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderView extends StatelessWidget {
  const _HeaderView({this.positionInQueue, required this.onBack});

  final int? positionInQueue;
  final Function()? onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: onBack, icon: Icon(Icons.arrow_back_ios_new_rounded)),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
              child: Image(image: Img.logoTurquoise, fit: BoxFit.contain)),
        )),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Job Event 123',
                  style: context.bodyLarge, maxLines: 1, softWrap: true),
              SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    CupertinoIcons.calendar,
                    color: context.textColor2,
                    size: context.titleSmall.fontSize,
                  ),
                  SizedBox(width: 4),
                  Text('01/01/2024 - 04/01/2024',
                      style: context.bodySmall, maxLines: 1, softWrap: true),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: IconButton(
              onPressed: () => (), icon: Icon(CupertinoIcons.qrcode, size: 40)),
        )
      ],
    );
  }
}

class _SectionHeaderView extends StatelessWidget {
  const _SectionHeaderView({required this.title, this.ctaStr, this.callback});

  final String title;
  final String? ctaStr;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: context.bodyLarge.fontSize,
                fontWeight: context.titleSmall.fontWeight,
              )),
          if (ctaStr != null)
            TextButton(
              onPressed: callback!,
              child: Text(
                ctaStr ?? '',
                style: TextStyle(
                  color: context.primary,
                  fontSize: context.bodySmall.fontSize,
                  fontWeight: context.titleSmall.fontWeight,
                ),
              ),
            )
        ],
      ),
    );
  }
}
