part of 'rating_cubit.dart';

@immutable
sealed class RatingState {}

final class RatingInitial extends RatingState {}

final class LoadingState extends RatingState {}

final class UpdateUIState extends RatingState {}
