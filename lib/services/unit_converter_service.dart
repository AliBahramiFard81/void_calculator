import 'package:main/common/converter_units.dart';
import 'package:main/common/enums.dart';

class UnitConverterService {
  Map<Enum, String> getSubUnits(UnitType unitType) {
    switch (unitType) {
      case UnitType.area:
        return ConverterUnits().areaUnitTitle;
      case UnitType.dataTransferRate:
        return ConverterUnits().areaUnitTitle;
      case UnitType.digitalStorage:
        return ConverterUnits().areaUnitTitle;
      case UnitType.energy:
        return ConverterUnits().areaUnitTitle;
      case UnitType.frequency:
        return ConverterUnits().areaUnitTitle;
      case UnitType.length:
        return ConverterUnits().lengthUnitTitle;
      case UnitType.mass:
        return ConverterUnits().areaUnitTitle;
      case UnitType.pressure:
        return ConverterUnits().areaUnitTitle;
      case UnitType.speed:
        return ConverterUnits().areaUnitTitle;
      case UnitType.temperature:
        return ConverterUnits().areaUnitTitle;
      case UnitType.time:
        return ConverterUnits().areaUnitTitle;
      case UnitType.volume:
        return ConverterUnits().areaUnitTitle;
    }
  }
}
