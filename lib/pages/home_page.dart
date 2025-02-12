import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/get_homepage_bloc.dart';
import 'package:main/common/colors.dart';
import 'package:main/pages/simple_calculator_page.dart';
import 'package:main/widgets/common_appbar.dart';
import 'package:main/widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BlocListener<GetHomepageBloc, GetHomepageState>(
      listener: (context, state) {},
      child: BlocBuilder<GetHomepageBloc, GetHomepageState>(
        builder: (context, state) {
          return Scaffold(
            drawer: CustomDrawer(),
            backgroundColor:
                brightness == Brightness.light
                    ? lightBackgroundColor
                    : darkBackgroundColor,
            appBar: CommonAppbar(title: 'Simple Calculator'),
            body: Center(
              child:
                  state is GetHomePageLoading
                      ? const CircularProgressIndicator()
                      : SimpleCalculatorPage(),
            ),
          );
        },
      ),
    );
  }
}
