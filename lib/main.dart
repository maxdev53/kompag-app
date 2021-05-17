import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import './screens/screen.dart';
import 'package:get/get.dart';
import 'package:flutter_login_register_ui/components/introduction_screen.dart';
import 'package:flutter_login_register_ui/components/splash_screen.dart';
import 'package:flutter_login_register_ui/screens/dashboard/home_screen.dart';
import 'package:flutter_login_register_ui/screens/dashboard/main.dart';
import 'package:flutter_login_register_ui/screens/dashboard/toko/detail_screen.dart';
import 'package:flutter_login_register_ui/screens/dashboard/toko/toko_screen.dart';

const URI = 'https://apikompag.maxproitsolution.com/api';
final storage = FlutterSecureStorage();
void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Kompag',
//       theme: ThemeData(
//         textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
//         scaffoldBackgroundColor: kBackgroundColor,
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: WelcomePage(),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        //  initialRoute: '/',
        getPages: routerPage,
        navigatorKey: Get.key,
        title: 'kompag PPRMB',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: DashboardScreen(),
        home: WelcomePage());
  }
}
