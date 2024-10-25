part of 'company_rating_cubit.dart';

@immutable
sealed class CompanyRatingState {}

final class CompanyRatingInitial extends CompanyRatingState {}

final class UpdateUIState extends CompanyRatingState {}
