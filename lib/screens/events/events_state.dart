part of 'events_cubit.dart';

@immutable
sealed class EventsState {}

final class EventsInitial extends EventsState {}

final class UpdateUIState extends EventsState {}
