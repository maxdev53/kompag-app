import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/helpers/storage.dart';
import 'package:flutter_login_register_ui/router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'constants.dart';
import './screens/screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _token;
  bool _isValidToken = false;
  bool _pageLoad = false;

  Future<String> getToken() async {
    String token = await getStorageData('token');
    // print(token);
    return token;
  }

  Future<String> checkValidToken(String token) async {
    String url = 'https://apikompag.maxproitsolution.com/api/auth/checkToken';
    // String token = await storage.read(key: 'token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    //  String json =
    var response = await http.post(
      url,
      headers: headers,
    );
    // print(response.body);
    setState(() {
      _pageLoad = false;
      response.statusCode == 200 ? _isValidToken = true : _isValidToken = false;
    });

    return response.body;
  }

  @override
  void initState() {
    _pageLoad = true;
    getToken().then((token) => {checkValidToken(token)});
    super.initState();
  }

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
        home: SplashScreenView(
          // text: "Kompag PPRMB",
          // textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
          imageSrc: "assets/images/logo_maxpos.png",
          home: _isValidToken ? DashboardScreen() : WelcomePage(),
          duration: 2,
        ));
    // home: DashboardScreen(),
    // home:  _isValidToken ? DashboardScreen():WelcomePage());
  }
}
