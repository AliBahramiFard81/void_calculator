part of 'unit_converter_from_to_button_cubit.dart';

@immutable
sealed class UnitConverterFromToButtonState {}

final class UnitConverterFromToButtonInitial
    extends UnitConverterFromToButtonState {}

final class UnitConverterFromToButtonChanged
    extends UnitConverterFromToButtonState {
  final List<String> title;
  UnitConverterFromToButtonChanged({required this.title});
}
