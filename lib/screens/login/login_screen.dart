import 'dart:async';
import 'dart:convert';

import 'package:bottom_loader/bottom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/animations/fade_animation.dart';
import 'package:flutter_login_register_ui/components/responsive.dart';
import 'package:flutter_login_register_ui/components/rounded_input_field.dart';
import 'package:flutter_login_register_ui/components/rounded_password_field.dart';
import 'package:flutter_login_register_ui/screens/dashboard/main.dart';
import 'package:flutter_login_register_ui/screens/screen.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  int _attempLogin = 0;
  bool _saving = false;
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

    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.0,
                      Container(
                        height: 380,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/login_icon2.png'),
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1.2,
                      Container(
                        child: Center(
                          child: RoundedInputField(
                            formKey: _usernameKey,
                            inputType: TextInputType.text,
                            colorIcon: Colors.black,
                            controller: emailController,
                            hintText: "Email/No hp",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.safeBlockHorizontal * 1),
                    FadeAnimation(
                      1.4,
                      Container(
                        child: Center(
                          child: RoundedPasswordField(
                            formKey: _passwordKey,
                            controller: passwordController,
                            colorIcon: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    FadeAnimation(
                      1.6,
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
                            if (_attempLogin > 3) {
                              showToast(
                                  'Anda melakukan kesalahan lebih dari 3x, harap hubungi admin ',
                                  position: StyledToastPosition.center,
                                  context: context,
                                  duration: Duration(seconds: 5),
                                  animation: StyledToastAnimation.fade);
                            } else {
                              if (_usernameKey.currentState.validate() &&
                                  _passwordKey.currentState.validate()) {
                                // await registerAkun();
                                setState(() {
                                  _saving = true;
                                });
                                // bl.display();
                                var email = emailController.text;
                                var password = passwordController.text;

                                var jwt = await attemptLogin(email, password);
                                // print(object)
                                // bl.close();
                                setState(() {
                                  _saving = false;
                                });

                                if (jwt != null) {
                                  var body = json.decode(jwt);
                                  //save shared preferences

                                  var token = body['data']['token'];
                                  // print(token);
                                  var nama = body['data']['name'];
                                  var memberId = body['data']['member_id'];
                                  var noHp = body['data']['no_hp'];
                                  var photo = body['data']['photo'];
                                  // print(memberId);
                                  storage.write(key: 'token', value: token);
                                  storage.write(key: 'nama', value: nama);
                                  storage.write(key: 'no_hp', value: noHp);
                                  storage.write(key: 'photo', value: photo);
                                  storage.write(
                                      key: 'memberId', value: memberId);

                                  // ToastBadge.show("Login berhasil",
                                  //     mode: ToastMode.INFO,
                                  //     duration: Duration(seconds: 2));
                                  //
                                  setState(() {
                                    _attempLogin = 0;
                                  });
                                  showToast('Login berhasil , tunggu ... ',
                                      position: StyledToastPosition.top,
                                      context: context,
                                      duration: Duration(seconds: 2),
                                      animation: StyledToastAnimation.fade);
                                  // }
                                  new Timer(const Duration(seconds: 2), () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                DashboardScreen()),
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
                                  setState(() {
                                    _attempLogin += 1;
                                  });
                                  showToast(
                                      'Login gagal, cek data anda atau hubungi admin ! ',
                                      position: StyledToastPosition.center,
                                      context: context,
                                      duration: Duration(seconds: 2),
                                      animation: StyledToastAnimation.fade);
                                }
                              }
                            }
                          },
                          child: Container(
                            height: SizeConfig.safeBlockHorizontal * 13,
                            width: SizeConfig.safeBlockHorizontal * 86,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.black
                                // gradient: LinearGradient(
                                //   colors: [
                                //     Color.fromRGBO(8, 0, 0, 8),
                                //     Color.fromRGBO(245, 235, 235, .6)
                                //   ],
                                // ),
                                ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    // SizedBox(height: 70,),
                    FadeAnimation(
                      1.8,
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
                                  type: PageTransitionType.leftToRightWithFade,
                                  // alignment: Alignment.centerLeft,
                                  // child: RegisterPage(
                                  //   haveName: false,
                                  // ),
                                  child: RegisterPage(
                                    haveName: false,
                                  ),
                                ),
                              );
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
                    ),
                    // SizedBox(height: size.height * 0.01),

                    FadeAnimation(
                      2.0,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              // print("Register Tapped");
                              Navigator.push(
                                context,
                                PageTransition(
                                  duration: Duration(milliseconds: 700),
                                  type: PageTransitionType.bottomToTop,
                                  // alignment: Alignment.centerLeft,
                                  // child: RegisterPage(
                                  //   haveName: false,
                                  // ),
                                  child: WelcomePage(
                                      // haveName: false,
                                      ),
                                ),
                              );
                            },
                            child: Text(
                              "kembali",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
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
      ),
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
