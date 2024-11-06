part of 'interviews_cubit.dart';

@immutable
sealed class InterviewsState {}

final class InterviewsInitial extends InterviewsState {}
final class LoadingState extends InterviewsState {}

final class UpdateUIState extends InterviewsState {}

final class ErrorState extends InterviewsState {
  final String msg;
  ErrorState(this.msg);
}
