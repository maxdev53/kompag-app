import 'package:awesome_button/awesome_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
// import 'package:maxposv2/screens/login/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:slider_button/slider_button.dart';

class IntroScreen extends StatelessWidget {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
          image: Center(
            child: Image.asset(
                'assets/images/drawkit-grape-pack-illustration-3.png'),
          ),
          title: 'Selamat datang di Maxpos App',
          body: 'Semua lebih mudah dengan Maxpos App',
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(color: Colors.white),
            bodyTextStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
                color: Colors.white),
            pageColor: Colors.lightGreen,
          ),
          footer: Text('@maxproitsolution',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ))),
      PageViewModel(
          image: Center(
            child: Image.asset(
                'assets/images/drawkit-grape-pack-illustration-1.png'),
          ),
          title: 'Kapanpun dan dimanapu',
          body: 'Semua lebih mudah dengan Maxpos App',
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(color: Colors.white),
            bodyTextStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
                color: Colors.white),
            pageColor: Colors.red,
          ),
          footer: Text('@maxproitsolution',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ))),
      PageViewModel(
          image: Center(
            child: Image.asset(
                'assets/images/drawkit-grape-pack-illustration-2.png'),
          ),
          title: 'Gak perlu repot',
          body: 'Semua lebih mudah dengan Maxpos App',
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(color: Colors.white),
            bodyTextStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
                color: Colors.white),
            pageColor: Colors.deepPurple,
          ),
          footer: Text('@maxproitsolution',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ))),
      PageViewModel(
        image: Center(
          child: Image.asset(
              'assets/images/drawkit-grape-pack-illustration-8.png'),
        ),
        title: 'Mudah digunakan',
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(color: Colors.white),
          bodyTextStyle: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 20.0, color: Colors.white),
          pageColor: Colors.lightBlueAccent,
        ),
        body: 'Semua lebih mudah dengan Maxpos App',
        footer: Center(
          child: SliderButton(
            action: () {
              ///Do something here
              // Navigator.of(context).pop();
              print('ok');
            },
            label: Text(
              "Mari bergabung",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
            icon: Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 40.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            ),

            ///Change All the color and size from here.
            // width: 230,
            // radius: 10,
            buttonSize: 70,
            buttonColor: Colors.lightBlueAccent,
            // backgroundColor: Color(0xff534bae),
            highlightedColor: Colors.white,
            baseColor: Colors.black,
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      curve: Curves.bounceInOut,
      animationDuration: 400,
      // done: Text(
      //   'Done',
      //   style: TextStyle(color: Colors.black),
      // ),
      onDone: () {
        // Navigator.push(
        //     context,
        //     PageTransition(
        //         type: PageTransitionType.fade, child: LoginScreen()));
      },
      pages: getPages(),
      globalBackgroundColor: Colors.white,
      onSkip: () {},
      // showSkipButton: true,
      // skip: const Icon(Icons.skip_next),
      showSkipButton: true,
      skip: const Text(
        "Skip",
        style: TextStyle(color: Colors.white),
      ),
      next: const Icon(
        Icons.navigate_next,
        color: Colors.white,
      ),
      done: AwesomeButton(
        blurRadius: 10.0,
        splashColor: Color.fromRGBO(255, 255, 255, .4),
        borderRadius: BorderRadius.circular(50.0),
        height: 50.0,
        width: 60.0,
        // onTap: () => Navigator.push(
        //     context,
        //     PageTransition(
        //       // curve: Curves.easeIn,
        //         type: PageTransitionType.leftToRight, child: LoginScreen())),
        // color: Colors.lightBlueAccent,
        child: Icon(
          Icons.login,
          color: Colors.white,
          size: 50.0,
        ),
      ),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Colors.white,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }
}
