import 'package:flutter/material.dart';

class EventHome extends StatelessWidget {
  const EventHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [Text('Event')],
          ),
        ),
      ),
    );
  }
}
