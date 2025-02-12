import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/common/colors.dart';
import 'package:main/common/enums.dart';
import 'package:main/cubit/unit_converter_button_cubit.dart';
import 'package:main/cubit/unit_converter_cubit.dart';
import 'package:sizer/sizer.dart';

class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  UnitType unitType = UnitType.area;
  Map<UnitType, String> unitTypeTitle = {
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
                                  unitTypeTitle.entries
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
                                    unitTypeTitle.entries
                                        .where(
                                          (element) =>
                                              element.key ==
                                              UnitType.values.elementAt(index),
                                        )
                                        .first
                                        .value,
                                  );
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
        ],
      ),
    );
  }
}
