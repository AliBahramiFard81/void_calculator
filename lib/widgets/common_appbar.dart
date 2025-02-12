import 'package:flutter/material.dart';
import 'package:main/common/colors.dart';
import 'package:sizer/sizer.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CommonAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontFamily: 'nothing', fontSize: 18.sp),
      ),
      centerTitle: true,
      backgroundColor:
          brightness == Brightness.light
              ? lightBackgroundColor
              : darkBackgroundColor,
      leading: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: Icon(Icons.menu_rounded),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(6.5.h);
}
