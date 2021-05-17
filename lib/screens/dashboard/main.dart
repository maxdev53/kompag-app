import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'bottom_nav_screen.dart';
// import 'package:maxposv2/screens/dashboard/bottom_nav_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard Maxpos',
      theme: ThemeData(
        // primarySwatch: Hexcolor('#ed0e0e'),
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavScreen(),
    );
  }
}
