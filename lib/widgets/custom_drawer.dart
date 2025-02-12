import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/theme_bloc.dart';
import 'package:main/common/colors.dart';
import 'package:sizer/sizer.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Drawer(
      backgroundColor:
          brightness == Brightness.light
              ? lightBackgroundColor
              : darkBackgroundColor,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.w),
            height: 6.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Void Calculator',
                  style: TextStyle(fontFamily: 'nothing', fontSize: 17.sp),
                ),
                BlocBuilder<ThemeBloc, ThemeData>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        BlocProvider.of<ThemeBloc>(
                          context,
                        ).add(ThemeSwitchEvent(context: context));
                      },
                      icon:
                          Theme.of(context).brightness == Brightness.dark
                              ? const Icon(Icons.wb_sunny_rounded)
                              : const Icon(Icons.dark_mode_rounded),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
