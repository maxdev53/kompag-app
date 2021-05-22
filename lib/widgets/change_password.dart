import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/config/styles.dart';
import 'package:flutter_login_register_ui/main.dart';
import 'package:flutter_login_register_ui/models/services.dart';
import 'package:flutter_login_register_ui/screens/screens.dart';
import 'package:flutter_login_register_ui/screens/welcome_page.dart';
import 'package:flutter_login_register_ui/widgets/my_password_field.dart';
import 'package:flutter_login_register_ui/widgets/my_text_button.dart';
import 'package:flutter_login_register_ui/widgets/widgets.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:queen_alerts/queen_alerts.dart';

class ChangePasswordWidget extends StatefulWidget {
  ChangePasswordWidget({Key key}) : super(key: key);

  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  bool isPasswordVisible = true;
  bool isPasswordVisibleNew = true;
  bool isPasswordVisibleConfirm = true;
  bool _saving = false;

  final _oldPasswordKey = GlobalKey<FormState>();
  final _newPasswordKey = GlobalKey<FormState>();
  final _confirmPasswordKey = GlobalKey<FormState>();

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
                  'Pengaturan password',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600),
                ),
                Text('*Harap ingat password anda',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
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
          Container(
            margin: EdgeInsets.only(top: 85.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyPasswordField(
                  formKey: _oldPasswordKey,
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
                  formKey: _newPasswordKey,
                  controller: newPasswordController,
                  isPasswordVisible: isPasswordVisibleNew,
                  onTap: () {
                    setState(() {
                      isPasswordVisibleNew = !isPasswordVisibleNew;
                    });
                  },
                ),
                MyPasswordField(
                  formKey: _confirmPasswordKey,
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
                SizedBox(
                  height: screenHeight * 0.16,
                ),

                Center(
                  child: MyTextButton(
                      borderColor: Colors.white,
                      bgColor: Colors.redAccent,
                      buttonName: 'Ubah password',
                      onTap: () async {
                        String oldPw = oldPasswordController.text;
                        String newPw = newPasswordController.text;
                        String confirmPw = confirmPasswordController.text;
                        if (oldPw.isEmpty ||
                            newPw.isEmpty ||
                            confirmPw.isEmpty) {
                          showToast('Harap isi data yang kosong',
                              context: context,
                              position: StyledToastPosition.bottom,
                              animation: StyledToastAnimation.scale);
                        } else if (newPw != confirmPw) {
                          showToast('Password baru dan konfirmasi tidak cocok',
                              context: context,
                              position: StyledToastPosition.bottom,
                              animation: StyledToastAnimation.scale);
                        } else {
                          setState(() {
                            _saving = true;
                          });
                          Services.changePassword(oldPw, newPw, confirmPw)
                              .then((data) => {
                                    print(data),
                                    setState(() => {_saving = false}),
                                    if (data != false)
                                      {
                                        showToast('Password berhasil diubah',
                                            context: context,
                                            position:
                                                StyledToastPosition.bottom,
                                            animation:
                                                StyledToastAnimation.scale),
                                        // QueenAlertsContiner(child: Prompt)
                                        oldPasswordController.clear(),
                                        newPasswordController.clear(),
                                        confirmPasswordController.clear()
                                      }
                                    else
                                      {
                                        showToast('Password gagal diubah',
                                            position:
                                                StyledToastPosition.bottom,
                                            context: context,
                                            animation:
                                                StyledToastAnimation.scale)
                                      }
                                  });
                        }

                        // response = await dio.post(url);
                      },
                      // bgColor: Color(0xffd9ced6),
                      textColor: Colors.white),
                ),

                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 14.0),
                    child: InkWell(
                      onTap: () {
                        // print("Register Tapped");
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Duration(milliseconds: 700),
                            type: PageTransitionType.rightToLeft,
                            // alignment: Alignment.centerLeft,
                            // child: RegisterPage(
                            //   haveName: false,
                            // ),
                            child: BottomNavScreen(
                              pageIndex: 3,
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
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.008,
                ),
                Center(
                  child: Container(
                      // height: 200.0,
                      // width: 100.0,
                      // decoration: BoxDecoration(
                      // border: Border.all(width: 2.0),
                      // color: Colors.red,
                      // borderRadius: BorderRadius.circular(18)),
                      // padding: EdgeInsets.only(right: 20.0),
                      ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
