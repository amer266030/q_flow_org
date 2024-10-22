import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_flow_organizer/screens/rating/rating_cubit.dart';
import 'package:q_flow_organizer/theme_data/extensions/text_style_ext.dart';
import 'package:q_flow_organizer/theme_data/extensions/theme_ext.dart';

import '../../extensions/img_ext.dart';
import '../../mock_data/mock_data.dart';
import '../../model/user/company.dart';
import '../../reusable_components/buttons/primary_btn.dart';
import '../../reusable_components/star_rating_view.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key, required this.company});

  final Company company;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RatingCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<RatingCubit>();
        return Scaffold(
          body: ListView(padding: EdgeInsets.zero, children: [
            _ImgView(callback: (context) => cubit.navigateBack(context)),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company.name ?? '',
                    style: TextStyle(
                      fontSize: context.bodyLarge.fontSize,
                      fontWeight: FontWeight.bold,
                      color: context.textColor1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Divider(color: context.textColor2),
                  ),
                  Text('Rating',
                      style: TextStyle(
                        fontSize: context.bodyMedium.fontSize,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: BlocBuilder<RatingCubit, RatingState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: MockData()
                              .questions
                              .asMap()
                              .entries
                              .map((entry) => StarRatingView(
                                    title: entry.value.title ?? '',
                                    text: entry.value.text ?? '',
                                    selectedRating: cubit.ratings[entry.key],
                                    setRating: (rating) =>
                                        cubit.setRating(entry.key, rating),
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ),
                  Divider(color: context.textColor2)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
              child: PrimaryBtn(
                  callback: () => cubit.navigateBack(context), title: 'SUBMIT'),
            )
          ]),
        );
      }),
    );
  }
}

class _ImgView extends StatelessWidget {
  const _ImgView({
    required this.callback,
  });

  final Function(BuildContext) callback;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            Image(image: Img.logoPurple, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: IconButton(
                  onPressed: () => callback(context),
                  icon: Icon(CupertinoIcons.chevron_left_square,
                      size: context.titleLarge.fontSize,
                      color: context.textColor1)),
            )
          ],
        ),
      ),
    );
  }
}
