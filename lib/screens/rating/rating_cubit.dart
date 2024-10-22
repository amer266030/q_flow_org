import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../mock_data/mock_data.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingInitial());

  List<int> ratings = List.generate(MockData().questions.length, (index) => 1);

  void setRating(int idx, double rating) {
    ratings[idx] = rating.round();
    emitUpdate();
  }

  navigateBack(BuildContext context) => Navigator.of(context).pop();

  emitUpdate() => emit(UpdateUIState());
}
