import 'package:bloc/bloc.dart';
import 'package:main/common/enums.dart';
import 'package:meta/meta.dart';

part 'unit_converter_state.dart';

class UnitConverterCubit extends Cubit<UnitConverterState> {
  UnitConverterCubit() : super(UnitConverterInitial());

  void changeUnitType(UnitType unitType) {
    return emit(UnitConverterChanged(unitType: unitType));
  }
}
