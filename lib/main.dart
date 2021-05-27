import 'dart:io';

import 'package:colour/colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
// import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/helpers/storage.dart';
import 'package:flutter_login_register_ui/router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:new_version/new_version.dart';
import 'package:in_app_update/in_app_update.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
// import 'constants.dart';
import './screens/screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_login_register_ui/screens/dashboard/main.dart';

const URI = 'https://maxproitsolution.com/apikompag/api';
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

  AppUpdateInfo _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<AppUpdateInfo> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      info?.updateAvailability == UpdateAvailability.updateAvailable
          ? InAppUpdate.completeFlexibleUpdate()
              .catchError((e) => showSnack(e.toString()))
          : null;

      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  Future<String> getToken() async {
    String token = await getStorageData('token');
    return token;
  }

  Future<String> checkValidToken(String token) async {
    String url = 'https://maxproitsolution.com/apikompag/api/auth/checkToken';
    // String token = await storage.read(key: 'token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.post(
      url,
      headers: headers,
    );
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
    checkForUpdate();
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
        // primarySwatch: Colour("#D8C8C5"),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: SplashScreenView(
          imageSrc: "assets/images/logo_maxpos.png",
          home: _isValidToken ? DashboardScreen() : WelcomePage(),
          duration: 2,
        ),
      ),
    );
  }
}
