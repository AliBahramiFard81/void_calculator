import 'package:bloc/bloc.dart';
import 'package:main/common/converter_units.dart';
import 'package:meta/meta.dart';

part 'unit_converter_to_button_state.dart';

class UnitConverterToButtonCubit extends Cubit<UnitConverterToButtonState> {
  UnitConverterToButtonCubit()
    : super(
        UnitConverterToButtonChanged(
          title: ConverterUnits().areaUnitTitle.entries.elementAt(1).value,
        ),
      );

  void onUnitConverterButtonChanged(String title) {
    return emit(UnitConverterToButtonChanged(title: title));
  }
}
