part of 'get_homepage_bloc.dart';

@immutable
sealed class GetHomepageEvent {}

final class GetHomepage extends GetHomepageEvent {}

final class GetSimpleCalculatorPage extends GetHomepageEvent {}

final class GetUnitConverterPage extends GetHomepageEvent {}
