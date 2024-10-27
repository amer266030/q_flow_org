part of 'events_cubit.dart';

@immutable
sealed class EventsState {}

final class EventsInitial extends EventsState {}

final class LoadingState extends EventsState {}

final class UpdateUIState extends EventsState {}

final class ErrorState extends EventsState {
  final String msg;
  ErrorState(this.msg);
}
