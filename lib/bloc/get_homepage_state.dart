part of 'get_homepage_bloc.dart';

@immutable
sealed class GetHomepageState {}

final class GetHomepageInitial extends GetHomepageState {}

final class GetHomePageLoading extends GetHomepageState {}

final class GetHomePageFailed extends GetHomepageState {
  final String message;
  GetHomePageFailed(this.message);
}

final class GetHomePageSuccess extends GetHomepageState {}

final class GetUnitConverterPageSuccess extends GetHomepageState {}
