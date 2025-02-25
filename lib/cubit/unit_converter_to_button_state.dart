part of 'unit_converter_to_button_cubit.dart';

@immutable
sealed class UnitConverterToButtonState {}

final class UnitConverterToButtonInitial extends UnitConverterToButtonState {}

final class UnitConverterToButtonChanged extends UnitConverterToButtonState {
  final String title;
  UnitConverterToButtonChanged({required this.title});
}
