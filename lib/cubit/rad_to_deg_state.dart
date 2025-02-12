part of 'rad_to_deg_cubit.dart';

@immutable
sealed class RadToDegState {}

final class RadToDegInitial extends RadToDegState {}

final class ChangeTriMode extends RadToDegState {
  final TriMode triMode;
  ChangeTriMode({required this.triMode});
}
