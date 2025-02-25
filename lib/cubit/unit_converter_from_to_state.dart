part of 'unit_converter_from_to_cubit.dart';

@immutable
sealed class UnitConverterFromToState {}

final class UnitConverterFromToInitial extends UnitConverterFromToState {}

final class UnitConverterFromToChanged extends UnitConverterFromToState {
  final Enum unitSubTypeTitle;
  UnitConverterFromToChanged({required this.unitSubTypeTitle});
}
