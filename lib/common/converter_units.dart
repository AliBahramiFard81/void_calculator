import 'package:main/common/enums.dart';

class ConverterUnits {
  Map<UnitType, String> get unitTypeTitle {
    return {
      UnitType.area: 'Area',
      UnitType.dataTransferRate: 'Data Transfer Rate',
      UnitType.digitalStorage: 'Digital Storage',
      UnitType.energy: 'Energy',
      UnitType.frequency: 'Frequency',
      UnitType.length: 'Length',
      UnitType.mass: 'Mass',
      UnitType.pressure: 'Pressure',
      UnitType.speed: 'Speed',
      UnitType.temperature: 'Temperature',
      UnitType.time: 'Time',
      UnitType.volume: 'Volume',
    };
  }

  Map<LengthUnit, String> get lengthUnitTitle {
    return {
      LengthUnit.millimeter: 'Millimeter',
      LengthUnit.centimeter: 'Centimeter',
      LengthUnit.meter: 'Meter',
      LengthUnit.kilometer: 'Kilometer',
      LengthUnit.inch: 'Inch',
      LengthUnit.foot: 'Foot',
      LengthUnit.yard: 'Yard',
      LengthUnit.mile: 'Mile',
      LengthUnit.nauticalMile: 'Nautical Mile',
    };
  }

  Map<AreaUnit, String> get areaUnitTitle {
    return {
      AreaUnit.squareMillimeter: 'Square Millimeter',
      AreaUnit.squareCentimeter: 'Square Centimeter',
      AreaUnit.squareMeter: 'Square Meter',
      AreaUnit.squareKilometer: 'Square Kilometer',
      AreaUnit.squareInch: 'Square Inch',
      AreaUnit.squareFoot: 'Square Foot',
      AreaUnit.squareYard: 'Square Yard',
      AreaUnit.squareMile: 'Square Mile',
      AreaUnit.acre: 'Acre',
      AreaUnit.hectare: 'Hectare',
    };
  }
}
