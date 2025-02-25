part of 'unit_converter_from_button_cubit.dart';

@immutable
sealed class UnitConverterFromButtonState {}

final class UnitConverterFromButtonInitial
    extends UnitConverterFromButtonState {}

final class UnitConverterFromButtonChanged
    extends UnitConverterFromButtonState {
  final String title;
  UnitConverterFromButtonChanged({required this.title});
}
