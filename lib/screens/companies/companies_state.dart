part of 'companies_cubit.dart';

@immutable
sealed class CompaniesState {}

final class CompaniesInitial extends CompaniesState {}

final class LoadingState extends CompaniesState {}

final class UpdateUIState extends CompaniesState {}

final class ErrorState extends CompaniesState {
  final String msg;
  ErrorState(this.msg);
}
