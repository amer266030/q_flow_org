import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:q_flow_organizer/extensions/img_ext.dart';
import 'package:q_flow_organizer/screens/events/events_cubit.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

import '../../reusable_components/buttons/floating_button_view.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsCubit(context),
      child: Builder(builder: (context) {
        final cubit = context.read<EventsCubit>();
        return Scaffold(
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
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () => cubit.navigateToHome(context),
                            child: _EventItemView(),
                          );
                        },
                        itemCount: 3,
                        viewportFraction: 0.8,
                        scale: 0.9,
                      ),
                    ),
                  ],
                ),
              ],
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
        Divider(color: context.textColor3, indent: 32, endIndent: 32),
      ],
    );
  }
}

class _EventItemView extends StatelessWidget {
  const _EventItemView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: context.bg3,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: context.textColor1.withOpacity(0.5),
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(4, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image(image: Img.logoPurple, fit: BoxFit.fill),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  children: [
                    Text(
                      '2024 Job Fair',
                      style: TextStyle(
                        fontSize: context.bodyLarge.fontSize,
                        fontWeight: FontWeight.bold,
                        color: context.textColor1,
                      ),
                      softWrap: true,
                      maxLines: 2,
                    ),
                    Text(
                      '04/01/2024 - 06/01/2024',
                      style: TextStyle(
                        fontSize: context.bodySmall.fontSize,
                        color: context.textColor3,
                      ),
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
