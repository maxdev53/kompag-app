import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/constants.dart';
import 'package:flutter_login_register_ui/services/storage.dart';
import 'package:flutter_login_register_ui/widgets/profile_list_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _nama;
  String _noHp;

  bool _loading = false;
  Future<String> getCredentials() async {
    String nama = await MyStorage().readData('nama');
    String no_hp = await MyStorage().readData('no_hp');
    setState(() {
      _noHp = no_hp;
      _nama = nama;
      _loading = false;
    });
    return nama;
  }

  @override
  void initState() {
    setState(() {
      _loading = true;
    });
    getCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init();
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () {
        var profileInfo = Expanded(
          child: _loading
              ? Container(
                  height: 450.0,
                  width: 300.0,
                  child: PKCardProfileSkeleton(
                    isCircularImage: false,
                    isBottomLinesActive: true,
                    // length: 8,
                  ),
                )
              : Column(
                  children: [
                    Container(
                      height: kSpacingUnit.w * 10,
                      width: kSpacingUnit.w * 10,
                      child: Stack(children: [
                        CircleAvatar(
                          radius: kSpacingUnit.w * 5,
                          backgroundImage: AssetImage("assets/images/man.png"),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: kSpacingUnit.w * 2.5,
                            width: kSpacingUnit.w * 2.5,
                            decoration: BoxDecoration(
                              color: Palette.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: kSpacingUnit * 2.0,
                            ),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: kSpacingUnit.w * 2,
                    ),
                    Text(
                      "$_nama",
                      style: kNameText,
                    ),
                    SizedBox(
                      height: kSpacingUnit.w * 0.5,
                    ),
                    Text(
                      "$_noHp",
                      style: kSubText,
                    ),
                  ],
                ),
        );
        var clipPathHeader = ClipPath(
          clipper: ArcClipper(),
          child: Container(
            height: 130.0,
            color: Palette.primaryColor,
          ),
        );
        var headerProfile = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: kSpacingUnit.w,
            ),
            // Icon(
            //   Icons.arrow_left,
            //   size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            // ),
            profileInfo,
            // Icon(
            //   Icons.wb_sunny,
            //   size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            // )
          ],
        );
        return Scaffold(
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              clipPathHeader,
              headerProfile,
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: kSpacingUnit.w * 4.0,
                    ),
                    ProfileListItem(
                      icon: Icons.person,
                      text: "profile",
                      pageDescription: "profile",
                    ),
                    ProfileListItem(
                      pageDescription: "password",
                      icon: Icons.security_rounded,
                      text: "ganti password",
                    ),
                    ProfileListItem(
                      icon: Icons.logout,
                      text: "keluar",
                      pageDescription: "exit",
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
