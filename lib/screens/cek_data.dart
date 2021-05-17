import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bottom_loader/bottom_loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/Models/member.dart';
import 'package:flutter_login_register_ui/Models/services.dart';
import 'package:flutter_login_register_ui/screens/list_user.dart';
import '../constants.dart';
import '../screens/screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../widgets/widget.dart';

class CekDataPage extends StatefulWidget {
  @override
  _CekDataPageState createState() => _CekDataPageState();
}

TextEditingController namaController = new TextEditingController();

class _CekDataPageState extends State<CekDataPage> {
  List<Member> _members;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    this.getMarga();
    // Services.getMembers(namaController.text).then((members) => {
    //   _members = members,
    //   _loading = false
    // });
  }

  TextEditingController namaController = new TextEditingController();
  bool isPasswordVisible = true;
  String margaId;
  List _marga;

  final String uri = 'https://apikompag.maxproitsolution.com/api';
  Future<String> getMarga() async {
    // var marga = await Services.getMarga();
    // print(marga);
    var res = await http.get(Uri.parse("$uri/statistik/select-marga"));
    var resBody = json.decode(res.body);

    setState(() {
      _marga = resBody['nama'];
    });

    return 'success';
  }

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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.black,
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
                            "Verifikasi data",
                            style: kHeadline,
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            "Silahkan masukan nama lengkap",
                            style: kBodyText2,
                          ),
                          SizedBox(
                            height: 68,
                          ),
                          MyTextField(
                            hintText: 'Nama',
                            controller: namaController,
                            inputType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Tidak ada nama anda? ",
                    //       style: kBodyText,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           CupertinoPageRoute(
                    //             builder: (context) => RegisterPage(),
                    //           ),
                    //         );
                    //       },
                    //       child: Text(
                    //         'Daftar',
                    //         style: kBodyText.copyWith(
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                        bgColor: Colors.black,
                        buttonName: 'Cari anggota',
                        onTap: () async {
                          // print('Pencarian nama : ' +
                          //     namaController.text +
                          //     '....');
                          // Response response;
                          // var dio = Dio();
                          bl.display();
                          Services.getMembers(namaController.text)
                              .then((members) => {
                                    bl.close(),
                                    namaController.clear(),
                                    setState(() {
                                      _members = members;
                                      _loading = false;
                                    }),
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => ListUser(
                                          members: members,
                                        ),
                                      ),
                                    ),

                                    // print(members)
                                  });
                          // response = await dio.post(url);
                        },
                        // bgColor: Color(0xffd9ced6),
                        textColor: Colors.white),
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
