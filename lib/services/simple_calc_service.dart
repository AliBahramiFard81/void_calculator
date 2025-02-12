import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/cubit/rad_to_deg_cubit.dart';
import 'package:main/cubit/simple_calc_viewer_cubit.dart';
import 'package:math_expressions/math_expressions.dart';

class SimpleCalcService {
  String equation = "";
  String result = "";
  String expression = "";

  final BuildContext context;
  final TextEditingController textEditingController;
  final ScrollController scrollController;
  SimpleCalcService({
    required this.context,
    required this.textEditingController,
    required this.scrollController,
  });
  int cursorPos = 0;
  void buttonPressed(String text) {
    cursorPos = textEditingController.selection.base.offset;
    if (text == 'AC' && text != 'triMode') {
      textEditingController.clear();
    } else if (text == '<' && cursorPos > 0 && text != 'triMode') {
      if (textEditingController.text.length > 2 && cursorPos > 1) {
        if (textEditingController.text.substring(cursorPos - 2, cursorPos) ==
                'n(' ||
            textEditingController.text.substring(cursorPos - 2, cursorPos) ==
                's(') {
          textEditingController.text = textEditingController.text.replaceRange(
            cursorPos - 4,
            cursorPos,
            '',
          );
          textEditingController.selection = TextSelection.collapsed(
            offset: cursorPos - 4,
          );
        } else {
          textEditingController.text = textEditingController.text.replaceRange(
            cursorPos - 1,
            cursorPos,
            '',
          );
          textEditingController.selection = TextSelection.collapsed(
            offset: cursorPos - 1,
          );
        }
      } else {
        textEditingController.text = textEditingController.text.replaceRange(
          cursorPos - 1,
          cursorPos,
          '',
        );
        textEditingController.selection = TextSelection.collapsed(
          offset: cursorPos - 1,
        );
      }
    } else if (text == '=' && text != 'triMode') {
      textEditingController.text = solver(textEditingController.text, text);
    } else if (text != '<' && text != 'triMode') {
      String textAfterCursor = textEditingController.text.substring(cursorPos);
      String textBeforeCursor = textEditingController.text.substring(
        0,
        cursorPos,
      );
      textEditingController.text = textBeforeCursor + text + textAfterCursor;
      textEditingController.selection = TextSelection.collapsed(
        offset: cursorPos + 1,
      );
      if (textEditingController.text.length > 10) {
        if (text.length > 3) {
          scrollController.jumpTo(
            scrollController.position.maxScrollExtent + 108,
          );
        } else {
          scrollController.jumpTo(
            scrollController.position.maxScrollExtent + 32,
          );
        }
      }
    }

    if (text.length > 2 || text == '√(') {
      if (text != 'triMode') {
        textEditingController.selection = TextSelection.collapsed(
          offset: cursorPos + text.length,
        );
      }
    }
    if (textEditingController.text == 'Error') {
      textEditingController.clear();
    }
    solver(textEditingController.text, text);
  }

  String solver(String equation, String text) {
    var triMode = BlocProvider.of<RadToDegCubit>(context).state;
    triMode as ChangeTriMode;
    expression = equation;
    expression = expression.replaceAll('x', '*');
    expression = expression.replaceAll('÷', '/');
    expression = expression.replaceAll('√', 'sqrt');
    expression = expression.replaceAll('log(', 'log(10,');
    if (triMode.triMode == TriMode.deg) {
      expression = expression.replaceAll('cos(', 'cos($pi/180*');
      expression = expression.replaceAll('sin(', 'sin($pi/180*');
      expression = expression.replaceAll('tan(', 'tan($pi/180*');
    }
    expression +=
        ")" *
        ("(".allMatches(expression).length - ")".allMatches(expression).length);
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      if (expression.contains('%')) {
        result = doesContainDecimal(result);
      }
    } catch (e) {
      result = "Error";
    }
    BlocProvider.of<SimpleCalcViewerCubit>(
      context,
    ).onChangeInput(equation, result, textLength(text));
    return result;
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }

  int textLength(String text) {
    return text.length;
  }
}
