// import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/components/introduction_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      home: IntroScreen(),
      duration: 4500,
      imageSize: 300,
      imageSrc: "assets/images/logo_maxpos.png",
      text: "MAXPOS",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 50.0,
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );
  }
}