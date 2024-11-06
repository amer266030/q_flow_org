part of 'visitor_rating_cubit.dart';

@immutable
sealed class VisitorRatingState {}

final class VisitorRatingInitial extends VisitorRatingState {}
final class LoadingState extends VisitorRatingState {}

final class UpdateUIState extends VisitorRatingState {}

final class ErrorState extends VisitorRatingState {
  final String msg;
  ErrorState(this.msg);
}
