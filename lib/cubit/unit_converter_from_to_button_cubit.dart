import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'unit_converter_from_to_button_state.dart';

class UnitConverterFromToButtonCubit
    extends Cubit<UnitConverterFromToButtonState> {
  UnitConverterFromToButtonCubit() : super(UnitConverterFromToButtonInitial());
  void onChanged(List<String> title) {
    return emit(UnitConverterFromToButtonChanged(title: title));
  }
}
