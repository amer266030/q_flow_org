part of 'company_rating_cubit.dart';

@immutable
sealed class CompanyRatingState {}

final class CompanyRatingInitial extends CompanyRatingState {}

final class LoadingState extends CompanyRatingState {}

final class UpdateUIState extends CompanyRatingState {}

final class ErrorState extends CompanyRatingState {
  final String msg;
  ErrorState(this.msg);
}
