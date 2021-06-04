import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/constants.dart';
import 'package:flutter_login_register_ui/helpers/storage.dart';
import 'package:flutter_login_register_ui/main.dart';
import 'package:flutter_login_register_ui/services/storage.dart';
import 'package:flutter_login_register_ui/widgets/profile_list_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

import '../welcome_page.dart';
import 'package:path/path.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _nama;
  String _noHp;
  String _photo;
  String _oneSignalUserId;
  bool _logoutLoading = false;

  bool _loading = false;

  Future<String> getCredentials() async {
    String nama = await MyAppStorage().readData('nama');
    String photo = await MyAppStorage().readData('photo');
    String no_hp = await MyAppStorage().readData('no_hp');
    String oneSignalUserId = await MyAppStorage().readData('oneSignalUserId');
    print(oneSignalUserId);
    setState(() {
      _noHp = no_hp;
      _photo = photo;
      _nama = nama;
      _oneSignalUserId = oneSignalUserId;
      _loading = false;
    });
    return nama;
  }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    setState(() {
      // _loading = false;
      _logoutLoading = true;
    });
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    String token = await getStorageData('token');

    Map<String, String> headers = {
      // "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    // print(oneSignalUserId);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("tidak ada foto yang dipilih");
      }
    });
    String filePath = _image.path;
    String namePhoto = basename(_image.path);

    var url =
        Uri.parse('https://maxproitsolution.com/apikompag/api/user-photo');

    var request = new http.MultipartRequest("POST", url);
    request.headers.addAll(headers);
    request.files.add(
      await http.MultipartFile.fromPath('photo', filePath
          //  File(_image).readAsBytes().asStream(),
          ),
    );
    // var response = await http.post(url, headers: headers, body: {
    //   'status': _statusController.text,
    //   'user_id': oneSignalUserId,
    //   'photo': base64Image
    //   // 'no_hp': noHpRegisterController.text,
    //   // 'email': emailRegisterController.text,
    // });

    request.send().then((response) => {
          print(response.statusCode),
          setState(() {
            // _loading = false;
            _logoutLoading = false;
          }),
          if (response.statusCode == 200)
            {
              storage.delete(key: 'photo'),
              storage.write(key: 'photo', value: "profil/member//" + namePhoto),
            }
          else
            {
              setState(() {
                // _image = '';
              }),
            }
        });
    // log(response.body);

    // return pickedFile;
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
    return ModalProgressHUD(
      inAsyncCall: _logoutLoading,
      child: ScreenUtilInit(
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
                            backgroundImage: (_photo != '' && _image == null)
                                ? NetworkImage(
                                    'https://maxproitsolution.com/apikompag/api/public/storage/' +
                                        _photo,
                                  )
                                : (_photo != '' && _image != null)
                                    ? FileImage(_image)
                                    : AssetImage("assets/images/man.png"),
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
                              child: IconButton(
                                onPressed: getImage,
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                  size: kSpacingUnit * 2.0,
                                ),
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
                      Text(
                        "id: $_oneSignalUserId",
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
                        onTap: (value) => {
                          if (value == false)
                            {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => WelcomePage(
                                      // pageIndex: 1,
                                      // memberDetail: _memberDetail
                                      ),
                                ),
                              ),
                              showToast('Akun anda berhasil keluar ',
                                  position: StyledToastPosition.top,
                                  context: context,
                                  duration: Duration(seconds: 2),
                                  animation: StyledToastAnimation.fade)
                            },
                          setState(() {
                            _logoutLoading = value;
                            // _liked ? _jumlahLike-- : _jumlahLike++;

                            // _liked = !_liked;
                          })
                        },
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
      ),
    );
  }
}
