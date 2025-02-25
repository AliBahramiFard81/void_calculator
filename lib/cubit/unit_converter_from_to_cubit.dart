import 'package:bloc/bloc.dart';
import 'package:main/common/converter_units.dart';
import 'package:main/common/enums.dart';
import 'package:main/services/unit_converter_service.dart';
import 'package:meta/meta.dart';

part 'unit_converter_from_to_state.dart';

class UnitConverterFromToCubit extends Cubit<UnitConverterFromToState> {
  UnitConverterFromToCubit() : super(UnitConverterFromToInitial());

  void changeSubUnitType(UnitType unitType, index) {
    Map<Enum, String> subUnits = UnitConverterService().getSubUnits(unitType);
    return emit(
      UnitConverterFromToChanged(
        unitSubTypeTitle: subUnits.keys.elementAt(index),
      ),
    );
  }
}
