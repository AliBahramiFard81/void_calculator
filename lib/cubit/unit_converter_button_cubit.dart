import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'unit_converter_button_state.dart';

class UnitConverterButtonCubit extends Cubit<UnitConverterButtonState> {
  UnitConverterButtonCubit() : super(UnitConverterButtonInitial());

  void onChanged(String title) {
    return emit(UnitConverterButtonChanged(title: title));
  }
}
