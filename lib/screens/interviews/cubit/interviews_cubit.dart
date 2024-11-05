import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'interviews_state.dart';

class InterviewsCubit extends Cubit<InterviewsState> {
  InterviewsCubit() : super(InterviewsInitial());
}
