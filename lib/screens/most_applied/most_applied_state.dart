part of 'most_applied_cubit.dart';

@immutable
sealed class MostAppliedState {}

final class MostAppliedInitial extends MostAppliedState {}

final class LoadingState extends MostAppliedState {}

final class UpdateUIState extends MostAppliedState {}
