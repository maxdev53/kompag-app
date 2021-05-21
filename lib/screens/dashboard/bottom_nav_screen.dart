import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/custom_icons/custom_icons_icons.dart';
import 'package:flutter_login_register_ui/fonts/my_flutter_app_icons.dart';
import 'package:flutter_login_register_ui/screens/dashboard/news_screen.dart';
import 'package:flutter_login_register_ui/screens/dashboard/toko/toko_screen.dart';
import 'package:flutter_login_register_ui/screens/dashboard/home_screen.dart';
import 'package:flutter_login_register_ui/screens/dashboard/profile_screen.dart';
import 'package:flutter_login_register_ui/screens/dashboard/setting_screen.dart';
import 'package:get/get.dart';

class BottomNavScreen extends StatefulWidget {
  int pageIndex;
  // dynamic memberDetail;
  BottomNavScreen({Key key, this.pageIndex}) : super(key: key);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final List _screens = [
    HomeScreen(),
    // BarangScreen(),
    ProfilScreen(),
    NewsScreen(),
    SettingScreen(),
  ];

  int _currentIndex = 0;
  // @override
  @override
  void initState() {
    setState(() {
      // print(Get.arguments);
      if (widget.pageIndex != null) {
        _currentIndex = widget.pageIndex;
      }
    });
    // print(Get.arguments);
    super.initState();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Apakah yakin?'),
              content: Text('ingin keluar App'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Batal'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('Ya'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            );
          },
        ) ??
        false;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          elevation: 0.0,
          items: [Icons.home, Icons.person, Icons.notifications, Icons.settings]
              .asMap()
              .map(
                (key, value) => MapEntry(
                  key,
                  BottomNavigationBarItem(
                    label: '',
                    icon: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: _currentIndex == key
                            ? Palette.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(value),
                    ),
                  ),
                ),
              )
              .values
              .toList(),
        ),
      ),
    );
  }
}
