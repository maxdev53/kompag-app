import 'package:flutter_login_register_ui/screens/dashboard/home_screen.dart';
import 'package:flutter_login_register_ui/screens/dashboard/toko/detail_screen.dart';
import 'package:flutter_login_register_ui/screens/dashboard/toko/toko_screen.dart';
import 'package:flutter_login_register_ui/screens/screens.dart';
import 'package:get/get.dart';

var routerPage = [
  GetPage(name: '/navigation', page: () => BottomNavScreen()),
  GetPage(name: '/', page: () => HomeScreen()),
  GetPage(name: '/toko', page: () => BarangScreen()),
  GetPage(
      name: '/toko/detail',
      page: () => DetailsScreen(),
      transition: Transition.zoom),
];
