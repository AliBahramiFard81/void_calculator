import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/common/colors.dart';
import 'package:main/common/converter_units.dart';
import 'package:main/common/enums.dart';
import 'package:main/cubit/unit_converter_button_cubit.dart';
import 'package:main/cubit/unit_converter_cubit.dart';
import 'package:main/cubit/unit_converter_from_button_cubit.dart';
import 'package:main/cubit/unit_converter_to_button_cubit.dart';
import 'package:main/services/unit_converter_service.dart';
import 'package:main/widgets/unit_converter_button.dart';
import 'package:sizer/sizer.dart';

class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  UnitType unitType = UnitType.area;
  Enum unitConverterFrom = ConverterUnits().areaUnitTitle.keys.elementAt(0);
  Enum unitConverterTo = ConverterUnits().areaUnitTitle.keys.elementAt(1);

  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    textEditingController.text = '25';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      margin: EdgeInsets.all(5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'From',
                    style: TextStyle(fontSize: 15.sp, fontFamily: 'nothing'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  child: AutoSizeTextField(
                    minFontSize: 10,
                    autofocus: true,
                    controller: textEditingController,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.all(0),
                    ),
                    style: TextStyle(fontSize: 25.sp, fontFamily: 'nothing'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'To',
                    style: TextStyle(fontSize: 15.sp, fontFamily: 'nothing'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                  alignment: AlignmentDirectional.centerStart,
                  height: 5.5.h,
                  child: SelectableText(
                    '25',
                    style: TextStyle(fontSize: 25.sp, fontFamily: 'nothing'),
                  ),
                ),
              ],
            ),
          ),
          MaterialButton(
            elevation: 0,
            highlightElevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                width: 0.5.w,
                color:
                    brightness == Brightness.light
                        ? lightDisplayColor
                        : darkDisplayColor,
              ),
            ),
            padding: EdgeInsets.all(4.w),
            child:
                BlocBuilder<UnitConverterButtonCubit, UnitConverterButtonState>(
                  builder: (context, state) {
                    state as UnitConverterButtonChanged;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state.title),
                        Icon(Icons.arrow_drop_down_rounded),
                      ],
                    );
                  },
                ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: UnitType.values.length,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                          value: UnitType.values.elementAt(index),
                          groupValue: unitType,
                          title: Text(
                            ConverterUnits().unitTypeTitle.entries
                                .where(
                                  (element) =>
                                      element.key ==
                                      UnitType.values.elementAt(index),
                                )
                                .first
                                .value,
                          ),
                          onChanged: (value) {
                            BlocProvider.of<UnitConverterCubit>(
                              context,
                            ).changeUnitType(UnitType.values.elementAt(index));
                            BlocProvider.of<UnitConverterButtonCubit>(
                              context,
                            ).onChanged(
                              ConverterUnits().unitTypeTitle.entries
                                  .where(
                                    (element) =>
                                        element.key ==
                                        UnitType.values.elementAt(index),
                                  )
                                  .first
                                  .value,
                            );
                            unitType = UnitType.values.elementAt(index);
                            Map<Enum, String> subUnits = UnitConverterService()
                                .getSubUnits(unitType);
                            unitConverterFrom = subUnits.keys.first;
                            unitConverterTo = subUnits.keys.elementAt(1);
                            BlocProvider.of<UnitConverterFromButtonCubit>(
                              context,
                            ).onUnitConverterButtonChanged(
                              subUnits.entries
                                  .where(
                                    (element) =>
                                        element.key ==
                                        subUnits.keys.elementAt(0),
                                  )
                                  .first
                                  .value,
                            );
                            BlocProvider.of<UnitConverterToButtonCubit>(
                              context,
                            ).onUnitConverterButtonChanged(
                              subUnits.entries
                                  .where(
                                    (element) =>
                                        element.key ==
                                        subUnits.keys.elementAt(1),
                                  )
                                  .first
                                  .value,
                            );
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    Map<Enum, String> subUnits = UnitConverterService()
                        .getSubUnits(unitType);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: subUnits.values.length,
                            itemBuilder: (context, index) {
                              if (subUnits.keys.elementAt(index) !=
                                  unitConverterTo) {
                                return RadioListTile(
                                  value: subUnits.keys.elementAt(index),
                                  groupValue: unitConverterFrom,
                                  title: Text(
                                    subUnits.entries
                                        .where(
                                          (element) =>
                                              element.key ==
                                              subUnits.keys.elementAt(index),
                                        )
                                        .first
                                        .value,
                                  ),
                                  onChanged: (value) {
                                    unitConverterFrom = value!;
                                    BlocProvider.of<
                                      UnitConverterFromButtonCubit
                                    >(context).onUnitConverterButtonChanged(
                                      subUnits.entries
                                          .where(
                                            (element) =>
                                                element.key ==
                                                subUnits.keys.elementAt(index),
                                          )
                                          .first
                                          .value,
                                    );
                                    Navigator.pop(context);
                                  },
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        );
                      },
                    );
                  },
                  padding: EdgeInsets.all(3.w),
                  highlightElevation: 0,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color:
                      brightness == Brightness.light
                          ? lightDisplayColor
                          : darkDisplayColor,
                  child: BlocBuilder<
                    UnitConverterFromButtonCubit,
                    UnitConverterFromButtonState
                  >(
                    builder: (context, state) {
                      state as UnitConverterFromButtonChanged;
                      return Text(state.title);
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.compare_arrows_rounded),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    Map<Enum, String> subUnits = UnitConverterService()
                        .getSubUnits(unitType);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: subUnits.values.length,
                            itemBuilder: (context, index) {
                              if (subUnits.keys.elementAt(index) !=
                                  unitConverterFrom) {
                                return RadioListTile(
                                  value: subUnits.keys.elementAt(index),
                                  groupValue: unitConverterTo,
                                  title: Text(
                                    subUnits.entries
                                        .where(
                                          (element) =>
                                              element.key ==
                                              subUnits.keys.elementAt(index),
                                        )
                                        .first
                                        .value,
                                  ),
                                  onChanged: (value) {
                                    unitConverterTo = value!;
                                    BlocProvider.of<UnitConverterToButtonCubit>(
                                      context,
                                    ).onUnitConverterButtonChanged(
                                      subUnits.entries
                                          .where(
                                            (element) =>
                                                element.key ==
                                                subUnits.keys.elementAt(index),
                                          )
                                          .first
                                          .value,
                                    );
                                    Navigator.pop(context);
                                  },
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        );
                      },
                    );
                  },
                  padding: EdgeInsets.all(3.w),
                  highlightElevation: 0,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color:
                      brightness == Brightness.light
                          ? lightDisplayColor
                          : darkDisplayColor,
                  child: BlocBuilder<
                    UnitConverterToButtonCubit,
                    UnitConverterToButtonState
                  >(
                    builder: (context, state) {
                      state as UnitConverterToButtonChanged;
                      return Text(state.title);
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UnitConverterButton(
                text: '7',
                buttonType: ButtonType.numbers,
                onPressed: () {},
              ),
              UnitConverterButton(
                text: '8',
                buttonType: ButtonType.numbers,
                onPressed: () {},
              ),
              UnitConverterButton(
                text: '9',
                buttonType: ButtonType.numbers,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UnitConverterButton(
                text: '4',
                buttonType: ButtonType.numbers,
                onPressed: () {},
              ),
              UnitConverterButton(
                text: '5',
                buttonType: ButtonType.numbers,
                onPressed: () {},
              ),
              UnitConverterButton(
                text: '6',
                buttonType: ButtonType.numbers,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UnitConverterButton(
                text: '1',
                buttonType: ButtonType.numbers,
                onPressed: () {},
              ),
              UnitConverterButton(
                text: '2',
                buttonType: ButtonType.numbers,
                onPressed: () {},
              ),
              UnitConverterButton(
                text: '3',
                buttonType: ButtonType.numbers,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UnitConverterButton(
                text: '0',
                buttonType: ButtonType.numbers,
                onPressed: () {},
              ),
              UnitConverterButton(
                text: '.',
                buttonType: ButtonType.numbers,
                onPressed: () {},
              ),
              UnitConverterButton(
                text: '<',
                buttonType: ButtonType.numbers,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
