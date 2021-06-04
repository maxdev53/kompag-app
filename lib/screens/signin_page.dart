import 'dart:convert';

import 'package:bottom_loader/bottom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../screens/screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../widgets/widget.dart';

class SignInPage extends StatefulWidget {
  bool keluar = false;
  SignInPage({Key key, this.keluar}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool isPasswordVisible = true;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (widget.keluar == true)
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => WelcomePage(),
                ),
              );
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => WelcomePage(),
              ),
            );
            // Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.white,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: SafeArea(
        //to make page scrollable
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: kHeadline,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   "Silahkan masuk",
                          //   style: kBodyText2,
                          // ),
                          SizedBox(
                            height: 60,
                          ),
                          MyTextField(
                            withIcon: false,
                            formKey: GlobalKey<FormState>(),

                            controller: emailController,
                            hintText: 'Email / No HP',
                            inputType: TextInputType.text,
                          ),
                          // MyPasswordField(
                          //   controller: passwordController,
                          //   isPasswordVisible: isPasswordVisible,
                          //   onTap: () {
                          //     setState(() {
                          //       isPasswordVisible = !isPasswordVisible;
                          //     });
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(
                        //   "Belum punya akun? ",
                        //   style: kBodyText,
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       CupertinoPageRoute(
                        //         builder: (context) => RegisterPage(),
                        //       ),
                        //     );
                        //   },
                        //   child: Text(
                        //     'Daftar',
                        //     style: kBodyText.copyWith(
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                        borderColor: Colors.white,

                      buttonName: 'Masuk',
                      onTap: () async {
                        bl.display();
                        var email = emailController.text;
                        var password = passwordController.text;

                        var jwt = await attemptLogin(email, password);
                        // print(object)
                        bl.close();

                        if (jwt != null) {
                          var body = json.decode(jwt);
                          var token = body['data']['token'];
                          var nama = body['data']['name'];
                          storage.write(key: 'token', value: token);
                          storage.write(key: 'nama', value: nama);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        }
                        // print(jwt);
                        // Create storage
                        // final storage = new FlutterSecureStorage();

                        // await storage.write(key: 'token', value: data.data);

                        // print(data);
                      },
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
