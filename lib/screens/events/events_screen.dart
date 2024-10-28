import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:q_flow_organizer/extensions/img_ext.dart';
import 'package:q_flow_organizer/screens/events/events_cubit.dart';
import 'package:q_flow_organizer/screens/events/subviews/event_item_view.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

import '../../reusable_components/buttons/floating_button_view.dart';
import '../../reusable_components/dialogs/error_dialog.dart';
import '../../reusable_components/dialogs/loading_dialog.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsCubit(context),
      child: Builder(builder: (context) {
        final cubit = context.read<EventsCubit>();
        return BlocListener<EventsCubit, EventsState>(
          listener: (context, state) async {
            if (cubit.previousState is LoadingState) {
              await Navigator.of(context).maybePop();
            }
            if (state is LoadingState && cubit.previousState is! LoadingState) {
              showLoadingDialog(context);
            }
            if (state is ErrorState) {
              showErrorDialog(context, state.msg);
            }
          },
          child: Scaffold(
            floatingActionButtonLocation: ExpandableFab.location,
            floatingActionButton: BlocBuilder<EventsCubit, EventsState>(
              builder: (context, state) {
                return FloatingButtonView(
                  isDarkMode: cubit.isDarkMode,
                  isEnglish: cubit.isEnglish,
                  languageToggle: () => cubit.toggleLanguage(context),
                  themeToggle: () => cubit.toggleDarkMode(context),
                  logout: () => cubit.logout(context),
                );
              },
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _PageHeaderView(),
                      SizedBox(height: 16),
                      _SectionHeaderView(
                          callback: () => cubit.navigateToAddEvent(context)),
                      SizedBox(height: 16),
                      AspectRatio(
                        aspectRatio: 1,
                        child: BlocBuilder<EventsCubit, EventsState>(
                          builder: (context, state) {
                            if (cubit.events.isEmpty) {
                              return Text('');
                            }
                            return Swiper(
                              key: ValueKey(cubit.events.length),
                              itemBuilder: (BuildContext context, int index) {
                                final event = cubit.events[index];
                                return InkWell(
                                  onTap: () => cubit.navigateToHome(
                                      context, cubit.events[index]),
                                  child: EventItemView(event: event),
                                );
                              },
                              itemCount: cubit.events.length,
                              viewportFraction: 0.8,
                              scale: 0.9,
                            );
                          },
                        ),
                      ),
                    ],
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

class _SectionHeaderView extends StatelessWidget {
  const _SectionHeaderView({required this.callback});

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Select an Event',
            style: TextStyle(
              color: context.textColor1,
              fontSize: context.bodyMedium.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: callback,
            child: Text(
              'Add Event',
              style: TextStyle(
                color: context.primary,
                fontSize: context.bodySmall.fontSize,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PageHeaderView extends StatelessWidget {
  const _PageHeaderView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ClipOval(
                  child: Image(image: Img.logoTurquoise, fit: BoxFit.contain),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                  flex: 4,
                  child: Text('Tuwaiq Academy', style: context.titleSmall))
            ],
          ),
        ),
        Divider(color: context.bg2, indent: 32, endIndent: 32),
      ],
    );
  }
}
