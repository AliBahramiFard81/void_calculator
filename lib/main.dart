import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/get_homepage_bloc.dart';
import 'package:main/bloc/theme_bloc.dart';
import 'package:main/common/converter_units.dart';
import 'package:main/common/enums.dart';
import 'package:main/cubit/rad_to_deg_cubit.dart';
import 'package:main/cubit/simple_calc_viewer_cubit.dart';
import 'package:main/cubit/unit_converter_button_cubit.dart';
import 'package:main/cubit/unit_converter_cubit.dart';
import 'package:main/cubit/unit_converter_from_button_cubit.dart';
import 'package:main/cubit/unit_converter_to_button_cubit.dart';
import 'package:main/pages/home_page.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(create: (context) => ThemeBloc(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => GetHomepageBloc()),
        BlocProvider(create: (context) => SimpleCalcViewerCubit()),
        BlocProvider(create: (context) => RadToDegCubit()),
        BlocProvider(create: (context) => UnitConverterCubit()),
        BlocProvider(create: (context) => UnitConverterButtonCubit()),
        BlocProvider(create: (context) => UnitConverterFromButtonCubit()),
        BlocProvider(create: (context) => UnitConverterToButtonCubit()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          BlocProvider.of<ThemeBloc>(context).add(InitialThemeSetEvent());
          //BlocProvider.of<GetHomepageBloc>(context).add(GetHomepage());
          BlocProvider.of<UnitConverterCubit>(
            context,
          ).changeUnitType(UnitType.area);
          BlocProvider.of<UnitConverterButtonCubit>(context).onChanged(
            ConverterUnits().unitTypeTitle.entries.elementAt(0).value,
          );
          return BlocListener<GetHomepageBloc, GetHomepageState>(
            listener: (context, state) {},
            child: BlocBuilder<ThemeBloc, ThemeData>(
              builder: (context, state) {
                return MaterialApp(
                  theme: state,
                  home: const HomePage(),
                  debugShowCheckedModeBanner: false,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
