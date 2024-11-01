part of 'top_majors_cubit.dart';

@immutable
sealed class TopMajorsState {}

final class TopMajorsInitial extends TopMajorsState {}
final class LoadingState extends TopMajorsState {}

final class UpdateUIState extends TopMajorsState {}