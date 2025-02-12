import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main/common/colors.dart';
import 'package:main/common/enums.dart';
import 'package:sizer/sizer.dart';

class SimpleCalcButton extends StatelessWidget {
  final ButtonType buttonType;
  final String text;
  final VoidCallback onPressed;
  const SimpleCalcButton({
    super.key,
    required this.text,
    required this.buttonType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    if (brightness == Brightness.light) {
      return SizedBox(
        height: 9.h,
        width: 9.h,
        child: MaterialButton(
          elevation: 0,
          highlightElevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () {
            onPressed();
            HapticFeedback.lightImpact();
          },
          color:
              buttonType == ButtonType.equal
                  ? nothingRedColor
                  : buttonType == ButtonType.numbers
                  ? lightNumberButtonColor
                  : lightFunctionButtonColor,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'nothing',
              fontSize: 19.sp,
              color:
                  buttonType == ButtonType.equal
                      ? Colors.white
                      : buttonType == ButtonType.numbers
                      ? Colors.black
                      : Colors.white,
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 9.h,
        width: 9.h,
        child: MaterialButton(
          elevation: 0,
          highlightElevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          color:
              buttonType == ButtonType.equal
                  ? nothingRedColor
                  : buttonType == ButtonType.numbers
                  ? darkNumberButtonColor
                  : darkFunctionButtonColor,
          onPressed: () {
            onPressed();
            HapticFeedback.lightImpact();
          },

          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'nothing',
              fontSize: 19.sp,
              color:
                  buttonType == ButtonType.equal
                      ? Colors.white
                      : buttonType == ButtonType.numbers
                      ? Colors.white
                      : Colors.black,
            ),
          ),
        ),
      );
    }
  }
}
