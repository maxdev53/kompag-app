import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  const CustomAppBar({Key key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
      leading: Builder(
        builder: (BuildContext context) {
          
          return Container();
          // return IconButton(
          //   icon: const Icon(Icons.menu),
          //   color: Colors.white,
          //   iconSize: 28.0,
          //   onPressed: () {
          //     print('navigation Bar');
          //     Scaffold.of(context).openDrawer();
          //   },
          //   tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          // );
        },
      ),
      actions: [
        //   IconButton(
        //     icon: const Icon(Icons.notifications_none),
        //     color: Colors.white,
        //     iconSize: 28.0,
        //     onPressed: () {
        //       print('navigation Bar');
        //     },
        //   ),
      ],
    );
  }
}
