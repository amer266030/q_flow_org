import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:q_flow_organizer/theme_data/app_colors.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

class FloatingButtonView extends StatelessWidget {
  const FloatingButtonView({
    super.key,
    required this.languageToggle,
    required this.themeToggle,
    required this.logout,
    required this.isEnglish,
    required this.isDarkMode,
  });
  final bool isEnglish;
  final bool isDarkMode;
  final VoidCallback languageToggle;
  final VoidCallback themeToggle;
  final VoidCallback logout;

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 85,
      openButtonBuilder: FloatingActionButtonBuilder(
        size: 60,
        builder: (context, open, animation) {
          return customFloatingActionBtnBuilder(
            onPressed: open,
            icon: CupertinoIcons.arrow_swap,
            heroTag: 'open',
          );
        },
      ),
      closeButtonBuilder: FloatingActionButtonBuilder(
        size: 60,
        builder: (context, close, animation) {
          return customFloatingActionBtnBuilder(
            onPressed: close,
            icon: CupertinoIcons.xmark,
            heroTag: 'close',
          );
        },
      ),
      children: [
        customFloatingActionBtn(
            heroTag: 'logout',
            onPressed: logout,
            child: const Icon(
              Icons.logout,
            )),
        customFloatingActionBtn(
            onPressed: themeToggle,
            heroTag: 'theme',
            child: Icon(
              isDarkMode ? CupertinoIcons.moon : CupertinoIcons.sun_max,
            )),
        customFloatingActionBtn(
            onPressed: languageToggle,
            heroTag: 'language',
            child: Text(
              isEnglish ? 'EN' : 'AR',
            )),
      ],
    );
  }
}

class customFloatingActionBtnBuilder extends StatelessWidget {
  const customFloatingActionBtnBuilder({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.heroTag,
  });
  final Function()? onPressed;
  final IconData icon;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: AppColors.lightText2, blurRadius: 1, offset: Offset(0, 1))
        ],
        gradient: LinearGradient(
          colors: [
            context.primary,
            context.primary.withOpacity(0.9),
            context.primary.withOpacity(0.8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        shape: BoxShape.circle,
      ),
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.darkText1,
        shape: const StadiumBorder(),
        onPressed: onPressed,
        child: Icon(icon),
        heroTag: heroTag,
      ),
    );
  }
}

class customFloatingActionBtn extends StatelessWidget {
  const customFloatingActionBtn({
    super.key,
    required this.onPressed,
    required this.child,
    required this.heroTag,
  });

  final VoidCallback onPressed;
  final Widget child;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: AppColors.lightText2, blurRadius: 1, offset: Offset(0, 1))
        ],
        gradient: LinearGradient(
          colors: [
            context.primary,
            context.primary.withOpacity(0.9),
            context.primary.withOpacity(0.8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        shape: BoxShape.circle,
      ),
      child: FloatingActionButton.small(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.darkText1,
        shape: const StadiumBorder(),
        onPressed: onPressed,
        heroTag: heroTag,
        child: child,
      ),
    );
  }
}
