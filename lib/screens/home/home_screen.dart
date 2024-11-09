import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/model/event/event.dart';
import 'package:q_flow_organizer/reusable_components/cards/report_cards.dart';
import 'package:q_flow_organizer/reusable_components/dialogs/error_dialog.dart';
import 'package:q_flow_organizer/reusable_components/dialogs/loading_dialog.dart';
import 'package:q_flow_organizer/screens/home/subviwes/stat_cards_view.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';
import '../../extensions/img_ext.dart';
import 'home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<HomeCubit>();
        return BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (cubit.previousState is LoadingState) {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            }

            if (state is LoadingState) {
              showLoadingDialog(context);
            }

            if (state is ErrorState) {
              showErrorDialog(context, state.msg);
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ListView(
                  children: [
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return _HeaderView(
                          onBack: () => cubit.navigateBack(context),
                          onScan: () => cubit.scanQR(context),
                          onEdit: () =>
                              cubit.navigateToEditEvent(context, event),
                          event: event,
                        );
                      },
                    ),
                    Divider(color: context.textColor3),
                    _SectionHeaderView(title: 'Overall Stats'),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return StatCardsView(
                          totalInvitedVisitors: cubit.totalInvitedVisitors,
                          totalInvitedCompanies: cubit.totalInvitedCompanies,
                          numCompanies: cubit.numCompanies,
                          numVisitors: cubit.numVisitors,
                          numInterviews: cubit.numInterviews,
                          viewCompanies: () =>
                              cubit.navigateToCompanies(context),
                          viewInterviews: () =>
                              cubit.navigateToInterviews(context),
                          viewVisitors: () => cubit.navigateToVisitors(context),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            _SectionHeaderView(title: 'Event Reports'),
                            SizedBox(
                              height: 6,
                            ),
                            ReportCards(
                              onTap: () => cubit.navigateToTopMajors(context),
                              title: 'Top In-demand\nMajors',
                              icon: Icons.pie_chart_rounded,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ReportCards(
                              onTap: () {
                                cubit.navigateToCompanyRating(context);
                              },
                              title: 'Total Company\nRating',
                              icon: Icons.bar_chart_rounded,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReportCards(
                              onTap: () => cubit.navigateToMostApplied(context),
                              title: 'Most applied\nfor companies',
                              icon: Icons.bar_chart_rounded,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ReportCards(
                              onTap: () => cubit.navigateToVisitorRating(
                                context,
                              ),
                              title: 'Total Visitor\nRating',
                              icon: Icons.bar_chart_rounded,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _HeaderView extends StatelessWidget {
  const _HeaderView({
    required this.onBack,
    required this.onScan,
    required this.event,
    required this.onEdit,
  });

  final Event event;
  final Function()? onBack;
  final Function()? onScan;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: onBack, icon: Icon(Icons.arrow_back_ios_new_rounded)),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(2),
          child: AspectRatio(
            aspectRatio: 1,
            child: InkWell(
              onTap: onEdit,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: event.imgUrl == null
                    ? Image(image: Img.logoOrange, fit: BoxFit.cover)
                    : FadeInImage(
                        placeholder: Img.logoOrange,
                        image: NetworkImage(event.imgUrl ?? ''),
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image(
                              image: Img.logoOrange, fit: BoxFit.cover);
                        },
                      ),
              ),
            ),
          ),
        )),
        const SizedBox(width: 8),
        Expanded(
          flex: 4,
          child: InkWell(
            onTap: onEdit,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.edit,
                      color: context.primary,
                      size: context.titleSmall.fontSize,
                    ),
                    SizedBox(width: 4),
                    Text(event.name ?? '',
                        style: context.bodyMedium, maxLines: 1, softWrap: true)
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      CupertinoIcons.calendar,
                      color: context.primary,
                      size: context.titleSmall.fontSize,
                    ),
                    SizedBox(width: 4),
                    Text('${event.startDate} - ${event.endDate}',
                        style: context.bodySmall, maxLines: 1, softWrap: true),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: IconButton(
              onPressed: onScan,
              icon: Icon(
                CupertinoIcons.qrcode_viewfinder,
                size: 40,
                color: context.textColor1,
              )),
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
