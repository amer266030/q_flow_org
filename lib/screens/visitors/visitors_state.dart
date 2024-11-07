part of 'visitors_cubit.dart';

@immutable
sealed class VisitorsState {}

final class VisitorsInitial extends VisitorsState {}

final class LoadingState extends VisitorsState {}

final class UpdateUIState extends VisitorsState {}

final class ErrorState extends VisitorsState {
  final String msg;
  ErrorState(this.msg);
}
