part of 'unit_converter_cubit.dart';

@immutable
sealed class UnitConverterState {}

final class UnitConverterInitial extends UnitConverterState {}

final class UnitConverterChanged extends UnitConverterState {
  final UnitType unitType;
  UnitConverterChanged({required this.unitType});
}
