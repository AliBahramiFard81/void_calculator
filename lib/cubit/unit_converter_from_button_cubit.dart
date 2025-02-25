import 'package:bloc/bloc.dart';
import 'package:main/common/converter_units.dart';
import 'package:meta/meta.dart';

part 'unit_converter_from_button_state.dart';

class UnitConverterFromButtonCubit extends Cubit<UnitConverterFromButtonState> {
  UnitConverterFromButtonCubit()
    : super(
        UnitConverterFromButtonChanged(
          title: ConverterUnits().areaUnitTitle.entries.elementAt(0).value,
        ),
      );

  void onUnitConverterButtonChanged(String title) {
    return emit(UnitConverterFromButtonChanged(title: title));
  }
}
