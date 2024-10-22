part of 'add_event_cubit.dart';

@immutable
sealed class AddEventState {}

final class AddEventInitial extends AddEventState {}

final class LoadingState extends AddEventState {}

final class UpdateUIState extends AddEventState {}
