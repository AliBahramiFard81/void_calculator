import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/common/colors.dart';
import 'package:main/common/enums.dart';
import 'package:main/cubit/rad_to_deg_cubit.dart';
import 'package:main/cubit/simple_calc_viewer_cubit.dart';
import 'package:main/services/simple_calc_service.dart';
import 'package:main/widgets/simple_calc_button.dart';
import 'package:sizer/sizer.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';

class SimpleCalculatorPage extends StatefulWidget {
  const SimpleCalculatorPage({super.key});

  @override
  State<SimpleCalculatorPage> createState() => _SimpleCalculatorPageState();
}

class _SimpleCalculatorPageState extends State<SimpleCalculatorPage> {
  late TextEditingController textEditingController;
  late ScrollController scrollController;
  int textLength = 0;
  @override
  void initState() {
    textEditingController = TextEditingController();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final SimpleCalcService simpleCalcService = SimpleCalcService(
      context: context,
      textEditingController: textEditingController,
      scrollController: scrollController,
    );

    return Container(
      margin: EdgeInsets.only(bottom: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:
                  brightness == Brightness.light
                      ? lightDisplayColor
                      : darkDisplayColor,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 2.w, top: 2.w),
                  alignment: AlignmentDirectional.centerStart,
                  child: BlocBuilder<RadToDegCubit, RadToDegState>(
                    builder: (context, state) {
                      state as ChangeTriMode;
                      return Text(
                        state.triMode == TriMode.deg
                            ? 'DEG'
                            : state.triMode == TriMode.rad
                            ? 'RAD'
                            : 'DEG',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'nothing',
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 10.h,
                  child: AutoSizeTextField(
                    minFontSize: 49,
                    autofocus: true,
                    controller: textEditingController,
                    scrollController: scrollController,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.all(0),
                    ),
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 35.sp, fontFamily: 'nothing'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  alignment: AlignmentDirectional.centerEnd,
                  height: 5.5.h,
                  child:
                      BlocBuilder<SimpleCalcViewerCubit, SimpleCalcViewerState>(
                        builder: (context, state) {
                          if (state is SimpleCalcViewerUpdate) {
                            textLength = state.textLength;
                            return SelectableText(
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontFamily: 'nothing',
                              ),
                              state.result == 'Error' ? '' : state.result,
                            );
                          } else {
                            return Text('');
                          }
                        },
                      ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleCalcButton(
                text: 'AC',
                buttonType: ButtonType.functions,
                onPressed: () => simpleCalcService.buttonPressed('AC'),
              ),
              SimpleCalcButton(
                text: '(',
                buttonType: ButtonType.functions,
                onPressed: () => simpleCalcService.buttonPressed('('),
              ),
              SimpleCalcButton(
                text: ')',
                buttonType: ButtonType.functions,
                onPressed: () => simpleCalcService.buttonPressed(')'),
              ),
              SimpleCalcButton(
                text: '√',
                buttonType: ButtonType.functions,
                onPressed: () => simpleCalcService.buttonPressed('√('),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleCalcButton(
                text: 'sin',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('sin('),
              ),
              SimpleCalcButton(
                text: 'cos',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('cos('),
              ),
              SimpleCalcButton(
                text: 'tan',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('tan('),
              ),
              BlocBuilder<RadToDegCubit, RadToDegState>(
                builder: (context, state) {
                  state as ChangeTriMode;
                  return SimpleCalcButton(
                    text:
                        state.triMode == TriMode.rad
                            ? 'DEG'
                            : state.triMode == TriMode.deg
                            ? 'RAD'
                            : 'DEG',
                    buttonType: ButtonType.functions,
                    onPressed: () {
                      if (state.triMode == TriMode.deg) {
                        BlocProvider.of<RadToDegCubit>(context).changeToRad();
                      } else {
                        BlocProvider.of<RadToDegCubit>(context).changeToDeg();
                      }
                      simpleCalcService.buttonPressed('triMode');
                    },
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleCalcButton(
                text: '^',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('^'),
              ),
              SimpleCalcButton(
                text: 'log',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('log('),
              ),
              SimpleCalcButton(
                text: '%',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('%'),
              ),
              SimpleCalcButton(
                text: '÷',
                buttonType: ButtonType.functions,
                onPressed: () => simpleCalcService.buttonPressed('÷'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleCalcButton(
                text: '7',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('7'),
              ),
              SimpleCalcButton(
                text: '8',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('8'),
              ),
              SimpleCalcButton(
                text: '9',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('9'),
              ),
              SimpleCalcButton(
                text: 'x',
                buttonType: ButtonType.functions,
                onPressed: () => simpleCalcService.buttonPressed('x'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleCalcButton(
                text: '4',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('4'),
              ),
              SimpleCalcButton(
                text: '5',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('5'),
              ),
              SimpleCalcButton(
                text: '6',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('6'),
              ),
              SimpleCalcButton(
                text: '-',
                buttonType: ButtonType.functions,
                onPressed: () => simpleCalcService.buttonPressed('-'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleCalcButton(
                text: '1',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('1'),
              ),
              SimpleCalcButton(
                text: '2',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('2'),
              ),
              SimpleCalcButton(
                text: '3',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('3'),
              ),
              SimpleCalcButton(
                text: '+',
                buttonType: ButtonType.functions,
                onPressed: () => simpleCalcService.buttonPressed('+'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleCalcButton(
                text: '0',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('0'),
              ),
              SimpleCalcButton(
                text: '.',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('.'),
              ),
              SimpleCalcButton(
                text: '<',
                buttonType: ButtonType.numbers,
                onPressed: () => simpleCalcService.buttonPressed('<'),
              ),
              SimpleCalcButton(
                text: '=',
                buttonType: ButtonType.equal,
                onPressed: () => simpleCalcService.buttonPressed('='),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
