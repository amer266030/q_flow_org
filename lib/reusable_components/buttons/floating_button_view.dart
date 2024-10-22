import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
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
          return FloatingActionButton(
            heroTag: null,
            backgroundColor: context.primary,
            shape: const StadiumBorder(),
            onPressed: open,
            child: const Icon(CupertinoIcons.arrow_swap, color: Colors.white),
          );
        },
      ),
      closeButtonBuilder: FloatingActionButtonBuilder(
        size: 60,
        builder: (context, close, animation) {
          return FloatingActionButton(
            heroTag: null,
            backgroundColor: context.primary,
            shape: const StadiumBorder(),
            onPressed: close,
            child: const Icon(CupertinoIcons.xmark, color: Colors.white),
          );
        },
      ),
      children: [
        FloatingActionButton.small(
          heroTag: null,
          backgroundColor: context.primary,
          shape: const StadiumBorder(),
          onPressed: logout,
          child: const Icon(Icons.logout, color: Colors.white),
        ),
        FloatingActionButton.small(
          heroTag: null,
          backgroundColor: context.primary,
          shape: const StadiumBorder(),
          onPressed: themeToggle,
          child: Icon(isDarkMode ? CupertinoIcons.moon : CupertinoIcons.sun_max,
              color: Colors.white),
        ),
        FloatingActionButton.small(
          heroTag: null,
          backgroundColor: context.primary,
          onPressed: languageToggle,
          shape: const StadiumBorder(),
          child: Text(isEnglish ? 'EN' : 'AR',
              style: TextStyle(color: context.bg1)),
        ),
      ],
    );
  }
}
