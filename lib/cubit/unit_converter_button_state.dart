part of 'unit_converter_button_cubit.dart';

@immutable
sealed class UnitConverterButtonState {}

final class UnitConverterButtonInitial extends UnitConverterButtonState {}

final class UnitConverterButtonChanged extends UnitConverterButtonState {
  final String title;
  UnitConverterButtonChanged({required this.title});
}
