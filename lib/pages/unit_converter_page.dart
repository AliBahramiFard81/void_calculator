import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/common/colors.dart';
import 'package:main/common/converter_units.dart';
import 'package:main/common/enums.dart';
import 'package:main/cubit/unit_converter_button_cubit.dart';
import 'package:main/cubit/unit_converter_cubit.dart';
import 'package:main/cubit/unit_converter_from_to_button_cubit.dart';
import 'package:main/cubit/unit_converter_from_to_cubit.dart';
import 'package:main/services/unit_converter_service.dart';
import 'package:sizer/sizer.dart';

class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  UnitType unitType = UnitType.area;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      margin: EdgeInsets.all(5.w),
      child: Column(
        children: [
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
                  return BlocBuilder<UnitConverterCubit, UnitConverterState>(
                    builder: (context, state) {
                      state as UnitConverterChanged;
                      return Dialog(
                        child: SizedBox(
                          height: 70.h,
                          child: ListView.builder(
                            itemCount: UnitType.values.length,
                            itemBuilder: (context, index) {
                              return RadioListTile(
                                value: UnitType.values.elementAt(index),
                                groupValue: state.unitType,
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
                                  ).changeUnitType(
                                    UnitType.values.elementAt(index),
                                  );
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
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          SizedBox(height: 5.h),
          BlocBuilder<
            UnitConverterFromToButtonCubit,
            UnitConverterFromToButtonState
          >(
            builder: (context, stateText) {
              stateText as UnitConverterFromToButtonChanged;
              return Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        Map<Enum, String> subUnits = UnitConverterService()
                            .getSubUnits(unitType);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return BlocBuilder<
                              UnitConverterFromToCubit,
                              UnitConverterFromToState
                            >(
                              builder: (context, state) {
                                state as UnitConverterFromToChanged;
                                return Dialog(
                                  child: SizedBox(
                                    height: 70.h,
                                    child: ListView.builder(
                                      itemCount: subUnits.values.length,
                                      itemBuilder: (context, index) {
                                        return RadioListTile(
                                          value: subUnits.keys.elementAt(index),
                                          groupValue: state.unitSubTypeTitle,
                                          title: Text(
                                            subUnits.entries
                                                .where(
                                                  (element) =>
                                                      element.key ==
                                                      subUnits.keys.elementAt(
                                                        index,
                                                      ),
                                                )
                                                .first
                                                .value,
                                          ),
                                          onChanged: (value) {
                                            BlocProvider.of<
                                              UnitConverterFromToCubit
                                            >(context).changeSubUnitType(
                                              unitType,
                                              index,
                                            );
                                            BlocProvider.of<
                                              UnitConverterFromToButtonCubit
                                            >(context).onChanged([
                                              subUnits.entries
                                                  .where(
                                                    (element) =>
                                                        element.key ==
                                                        subUnits.keys.elementAt(
                                                          index,
                                                        ),
                                                  )
                                                  .first
                                                  .value,
                                            ]);

                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
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
                      child: Text(stateText.title.first),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.compare_arrows_rounded),
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(3.w),
                      elevation: 0,
                      highlightElevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color:
                          brightness == Brightness.light
                              ? lightDisplayColor
                              : darkDisplayColor,
                      child: Text('Meter'),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
