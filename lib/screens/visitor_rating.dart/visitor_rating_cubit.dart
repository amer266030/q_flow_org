import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'visitor_rating_state.dart';

class VisitorRatingCubit extends Cubit<VisitorRatingState> {
  VisitorRatingCubit() : super(VisitorRatingInitial());
}
