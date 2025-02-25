import 'package:flutter/material.dart';
import 'package:main/common/converter_units.dart';
import 'package:main/common/enums.dart';

class UnitConverterService {
  final BuildContext? context;
  final TextEditingController? textEditingController;
  UnitConverterService({this.context, this.textEditingController});
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

  int cursorPos = 1;
  String expression = "";
  void buttonPressed(String text) {
    cursorPos = textEditingController!.selection.base.offset;
    if (text != '<' && textEditingController!.text.isNotEmpty) {
      String textAfterCursor = textEditingController!.text.substring(cursorPos);
      String textBeforeCursor = textEditingController!.text.substring(
        0,
        cursorPos,
      );
      textEditingController!.text = textBeforeCursor + text + textAfterCursor;
      textEditingController!.selection = TextSelection.collapsed(
        offset: cursorPos + 1,
      );
    } else if (text != '<') {
      textEditingController!.text = text;
    } else if (text == '<' && cursorPos > 0) {
      textEditingController!.text = textEditingController!.text.replaceRange(
        cursorPos - 1,
        cursorPos,
        '',
      );
      textEditingController!.selection = TextSelection.collapsed(
        offset: cursorPos - 1,
      );
    }
  }

  String Solver(String equation) {
    return '';
  }
}
