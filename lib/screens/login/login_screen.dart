import 'dart:async';
import 'dart:convert';

import 'package:bottom_loader/bottom_loader.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:flutter_login_register_ui/screens/screen.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_login_register_ui/animations/fade_animation.dart';
import 'package:flutter_login_register_ui/components/responsive.dart';
// import 'package:flutter_login_register_ui/components/rounded_button.dart';
import 'package:flutter_login_register_ui/components/rounded_input_field.dart';
import 'package:flutter_login_register_ui/components/rounded_password_field.dart';
import 'package:flutter_login_register_ui/screens/dashboard/main.dart';
import 'package:flutter_login_register_ui/screens/register/register_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast_badge/toast_badge.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var bl = new BottomLoader(
      context,
      showLogs: true,
      isDismissible: false,
    );
    bl.style(
        // progressWidget: ,
        // messageTextStyle: ,
        message: 'mohon tunggu...',
        messageTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ));
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/loginIcon.png'),
                          fit: BoxFit.fitWidth),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          height: SizeConfig.safeBlockVertical *
                              30, //10 for example
                          width: SizeConfig.safeBlockHorizontal * 40,
                          child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            ),
                          ),
                        ),
                        Positioned(
                          height: SizeConfig.safeBlockVertical *
                              21, //10 for example
                          width: SizeConfig.safeBlockHorizontal * 98,
                          child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            ),
                          ),
                        ),
                        Positioned(
                          height: SizeConfig.safeBlockVertical *
                              33, //10 for example
                          width: SizeConfig.safeBlockHorizontal * 160,
                          child: FadeAnimation(
                            1.6,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            ),
                          ),
                        ),
                        Positioned(
                            height: SizeConfig.safeBlockVertical *
                                55, //10 for example
                            width: SizeConfig.safeBlockHorizontal * 103,
                            child: FadeAnimation(
                              1.2,
                              Container(
                                child: Center(
                                    // child: Text(
                                    //   "login",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.normal,
                                    //       color: Colors.white,
                                    //       fontSize: 38),
                                    // ),
                                    ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  FadeAnimation(
                    1.5,
                    Container(
                      child: Center(
                        child: RoundedInputField(
                          colorIcon: Color.fromRGBO(245, 58, 58, 1),
                          controller: emailController,
                          hintText: "Email/No hp",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.safeBlockHorizontal * 1),
                  FadeAnimation(
                    1.8,
                    Container(
                      child: Center(
                        child: RoundedPasswordField(
                          controller: passwordController,
                          colorIcon: Color.fromRGBO(245, 58, 58, 1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  FadeAnimation(
                    2.1,
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        PageTransition(
                          duration: Duration(milliseconds: 600),
                          type: PageTransitionType.leftToRightWithFade,
                          child: DashboardScreen(),
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          bl.display();
                          var email = emailController.text;
                          var password = passwordController.text;

                          var jwt = await attemptLogin(email, password);
                          // print(object)
                          bl.close();

                          if (jwt != null) {
                            var body = json.decode(jwt);
                            //save shared preferences

                            var token = body['data']['token'];
                            // print(token);
                            var nama = body['data']['name'];
                            var memberId = body['data']['member_id'];
                            // print(memberId);
                            storage.write(key: 'token', value: token);
                            storage.write(key: 'nama', value: nama);
                            storage.write(key: 'memberId', value: memberId);

                            // ToastBadge.show("Login berhasil",
                            //     mode: ToastMode.INFO,
                            //     duration: Duration(seconds: 2));
                            //
                            FlutterFlexibleToast.showToast(
                                message: 'Login berhasil , tunggu ...',
                                toastLength: Toast.LENGTH_LONG,
                                toastGravity: ToastGravity.TOP,
                                icon: ICON.LOADING,
                                radius: 40,
                                elevation: 10,
                                imageSize: 12,
                                textColor: Colors.white,
                                backgroundColor: Colors.green,
                                timeInSeconds: 1);
                            // }
                            new Timer(const Duration(seconds: 2), () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                      builder: (context) => DashboardScreen()),
                                  (route) => false);

                              // );
                            });
                          } else {
                            // CoolAlert.show(
                            //     title: "Login gagal",
                            //     context: context,
                            //     type: CoolAlertType.error,
                            //     text: "Username atau Password salah");
                            // ToastBadge.show("Login gagal!",
                            //     mode: ToastMode.ERROR,
                            //     duration: Duration(seconds: 2));
                            //
                            FlutterFlexibleToast.showToast(
                                message: 'Login gagal',
                                toastLength: Toast.LENGTH_LONG,
                                toastGravity: ToastGravity.TOP,
                                icon: ICON.ERROR,
                                radius: 40,
                                elevation: 10,
                                imageSize: 12,
                                textColor: Colors.white,
                                backgroundColor: Colors.redAccent,
                                timeInSeconds: 1);
                          }
                        },
                        child: Container(
                          height: SizeConfig.safeBlockHorizontal * 13,
                          width: SizeConfig.safeBlockHorizontal * 86,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(245, 58, 58, 1),
                                Color.fromRGBO(245, 235, 235, .6)
                              ],
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  // SizedBox(height: 70,),
                  FadeAnimation(
                    2.8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Belum punya akun ?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        InkWell(
                          onTap: () {
                            print("Register Tapped");
                            Navigator.push(
                                context,
                                PageTransition(
                                    duration: Duration(milliseconds: 700),
                                    type:
                                        PageTransitionType.leftToRightWithFade,
                                    // alignment: Alignment.centerLeft,
                                    child: RegisterPage(
                                      haveName: false,
                                    )));
                          },
                          child: Text(
                            " Daftar",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

Future<String> attemptLogin(String email, String password) async {
  var url = Uri.parse("$URI/auth/login");
  var response = await http.post(url, body: {
    'email': email,
    'password': password,
  });
  if (response.statusCode == 200) return response.body;
  return null;
}
