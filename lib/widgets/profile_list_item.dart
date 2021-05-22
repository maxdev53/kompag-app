import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/constants.dart';
import 'package:flutter_login_register_ui/models/services.dart';
import 'package:flutter_login_register_ui/screens/screens.dart';
import 'package:flutter_login_register_ui/screens/welcome_page.dart';
import 'package:flutter_login_register_ui/widgets/change_password.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ProfileListItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final String pageDescription;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
    this.pageDescription = 'profile',
  }) : super(key: key);

  @override
  _ProfileListItemState createState() => _ProfileListItemState();
}

class _ProfileListItemState extends State<ProfileListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        switch (widget.pageDescription) {
          case 'profile':
            Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 700),
                type: PageTransitionType.leftToRight,
                child: BottomNavScreen(
                  pageIndex: 1,
                  // members: members,
                ),
              ),
            );
            break;
          case 'password':
            Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 700),
                type: PageTransitionType.leftToRight,
                child: ChangePasswordWidget(
                    // members: members,
                    ),
              ),
            );
            break;
          case 'exit':
            // Loader.show(context,progressIndicator:LinearProgressIndicator());
            var res = await Services.logOut().then((value) => {
                  // Loader.hide()
                });
            // print(res);
            // if (res) {
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
              // setState(() {
              //   _saving = false;
              // });
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
            // } else {
            //   // setState(() {
            //   //   _saving = false;
            //   // });
            //   showToast('Gagal , gangguan server ',
            //       position: StyledToastPosition.center,
            //       context: context,
            //       duration: Duration(seconds: 2),
            //       animation: StyledToastAnimation.fade);
            // }
            break;
          default:
        }
      },
      child: Container(
        height: kSpacingUnit * 5.5,
        margin: EdgeInsets.symmetric(
          horizontal: kSpacingUnit * 4.0,
        ).copyWith(
          bottom: kSpacingUnit * 2.0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: kSpacingUnit * 2.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSpacingUnit * 3.0),
          color: Palette.greyColor,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.widget.icon,
              size: kSpacingUnit * 2.5,
            ),
            SizedBox(width: kSpacingUnit * 1.5),
            Text(
              this.widget.text,
              style: kTitleTextStyle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () => {print('tap')},
              child: Icon(
                Icons.arrow_right,
                size: kSpacingUnit * 2.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
