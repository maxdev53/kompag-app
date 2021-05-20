import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/config/styles.dart';
import 'package:flutter_login_register_ui/models/services.dart';
import 'package:flutter_login_register_ui/widgets/my_password_field.dart';
import 'package:flutter_login_register_ui/widgets/my_text_button.dart';
import 'package:flutter_login_register_ui/widgets/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../welcome_page.dart';
// import 'package:queen_alerts/queen_alerts.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  bool isPasswordVisible = true;
  bool isPasswordVisibleNew = true;
  bool isPasswordVisibleConfirm = true;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar(color: Palette.primaryColor),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            _buildHeader(screenHeight),
            _buildChangePassword(screenHeight),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Palette.primaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45.0),
                bottomRight: Radius.circular(45.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: <Widget>[
            //     Text(
            //       'Maxpos',
            //       style: const TextStyle(
            //           color: Colors.white,
            //           fontSize: 30.0,
            //           fontWeight: FontWeight.bold),
            //     )
            //   ],
            // ),
            SizedBox(
              height: screenHeight * 0.001,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Setting',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600),
                ),
                Text('atur akun kamu disini',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton.icon(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        onPressed: () async {
                          setState(() {
                            _saving = true;
                          });

                          var res = await Services.logOut();
                          if (res) {
                            await storage.deleteAll();
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            await preferences.clear();
                            new Future.delayed(new Duration(seconds: 2), () {
                              showToast('Akun anda berhasil keluar ',
                                  position: StyledToastPosition.top,
                                  context: context,
                                  duration: Duration(seconds: 4),
                                  animation: StyledToastAnimation.fade);
                              setState(() {
                                _saving = false;
                              });
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => WelcomePage(
                                      // pageIndex: 1,
                                      // memberDetail: _memberDetail
                                      ),
                                ),
                              );
                            });
                          } else {
                            setState(() {
                              _saving = false;
                            });
                            showToast('Gagal , gangguan server ',
                                position: StyledToastPosition.center,
                                context: context,
                                duration: Duration(seconds: 2),
                                animation: StyledToastAnimation.fade);
                          }
                        },
                        icon: const Icon(Icons.featured_play_list,
                            color: Colors.black),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        label: Text('Keluar', style: Styles.buttonTextStyle),
                        textColor: Colors.black)
                  ],
                ),
                Row(
                  children: <Widget>[],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildChangePassword(double screenHeight) {
    return SliverToBoxAdapter(
        child: Container(
      padding: EdgeInsets.only(right: 14, left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: <Widget>[
          //     Text(
          //       'Maxpos',
          //       style: const TextStyle(
          //           color: Colors.white,
          //           fontSize: 30.0,
          //           fontWeight: FontWeight.bold),
          //     )
          //   ],
          // ),
          SizedBox(
            height: screenHeight * 0.001,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyPasswordField(
                hintText: "Password Lama",
                controller: oldPasswordController,
                isPasswordVisible: isPasswordVisible,
                onTap: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
              // isLoading ? Text('') : CircularProgressIndicator(),
              MyPasswordField(
                hintText: "Password baru",
                controller: newPasswordController,
                isPasswordVisible: isPasswordVisibleNew,
                onTap: () {
                  setState(() {
                    isPasswordVisibleNew = !isPasswordVisibleNew;
                  });
                },
              ),
              MyPasswordField(
                hintText: "Konfirmasi password",
                controller: confirmPasswordController,
                isPasswordVisible: isPasswordVisibleConfirm,
                onTap: () {
                  setState(() {
                    isPasswordVisibleConfirm = !isPasswordVisibleConfirm;
                  });
                },
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              // Row(
              //   children: <Widget>[
              //     FlatButton.icon(
              //         padding: const EdgeInsets.symmetric(
              //             vertical: 10.0, horizontal: 20.0),
              //         onPressed: () {
              //           print('featured list tapped');
              //         },
              //         icon: const Icon(Icons.featured_play_list,
              //             color: Colors.black),
              //         color: Colors.white,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(30.0)),
              //         label: Text('Featured List',
              //             style: Styles.buttonTextStyle),
              //         textColor: Colors.black)
              //   ],
              // )
              Center(
                child: MyTextButton(
                    bgColor: Colors.redAccent,
                    buttonName: 'Ubah password',
                    onTap: () async {
                      setState(() {
                        _saving = true;
                      });
                      String oldPw = oldPasswordController.text;
                      String newPw = newPasswordController.text;
                      String confirmPw = confirmPasswordController.text;

                      Services.changePassword(oldPw, newPw, confirmPw)
                          .then((data) => {
                                print(data),
                                setState(() => {_saving = false}),
                                if (data != false)
                                  {
                                    showToast('Password berhasil diubah',
                                        context: context,
                                        position: StyledToastPosition.bottom,
                                        animation: StyledToastAnimation.scale),
                                    // QueenAlertsContiner(child: Prompt)
                                    oldPasswordController.clear(),
                                    newPasswordController.clear(),
                                    confirmPasswordController.clear()
                                  }
                                else
                                  {
                                    showToast('Password gagal diubah',
                                        position: StyledToastPosition.bottom,
                                        context: context,
                                        animation: StyledToastAnimation.scale)
                                  }
                                // print(data),
                                // namaController.clear(),

                                // Navigator.push(
                                //   context,
                                //   CupertinoPageRoute(
                                //     builder: (context) => BottomNavScreen(
                                //         // members: members,
                                //         ),
                                //   ),
                                // ),

                                // print(members)
                              });
                      // response = await dio.post(url);
                    },
                    // bgColor: Color(0xffd9ced6),
                    textColor: Colors.white),
              )
            ],
          )
        ],
      ),
    ));
  }
}
