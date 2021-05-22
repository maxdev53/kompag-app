import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bottom_loader/bottom_loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/Models/member.dart';
import 'package:flutter_login_register_ui/Models/services.dart';
import 'package:flutter_login_register_ui/screens/list_user.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
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
  // bool _loading = false;
  bool _search = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // _loading = true;
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
    var res = await http.get(Uri.parse("$uri/statistik/select-marga"));
    var resBody = json.decode(res.body);

    setState(() {
      _marga = resBody['nama'];
    });

    return 'success';
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _search,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   leading: IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           PageTransition(
        //               duration: Duration(milliseconds: 700),
        //               type: PageTransitionType.leftToRightWithFade,
        //               // alignment: Alignment.centerLeft,
        //               child: WelcomePage()));
        //     },
        //     icon: Image(
        //       width: 24,
        //       color: Colors.black,
        //       image: Svg('assets/images/back_arrow.svg'),
        //     ),
        //   ),
        // ),

        body: SafeArea(
          //to make page scrollable
          child: CustomScrollView(
            reverse: true,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    margin: EdgeInsets.only(top: 60.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Container(
                        //   height: 80,
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         image:
                        //             AssetImage('assets/images/login_icon2.png'),
                        //         fit: BoxFit.fitWidth),
                        //   ),
                        // ),
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
                                formKey: _formKey,
                                hintText: 'Nama',
                                controller: namaController,
                                inputType: TextInputType.name,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 6.0),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: MyTextButton(
                                  borderColor: Colors.black,
                                  bgColor: Colors.white,
                                  buttonName: 'cari anggota',
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        _search = true;
                                      });
                                      Services.getMembers(namaController.text)
                                          .then((members) => {
                                                namaController.clear(),
                                                setState(() {
                                                  _members = members;
                                                  _search = true;
                                                }),
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    duration: Duration(
                                                        milliseconds: 700),
                                                    type: PageTransitionType
                                                        .leftToRight,
                                                    child: ListUser(
                                                      members: members,
                                                    ),
                                                  ),
                                                )
                                              });
                                    }
                                  },
                                  textColor: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: MyTextButton(
                                  borderColor: Colors.black,
                                  bgColor: Colors.transparent,
                                  buttonName: 'kembali',
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            duration:
                                                Duration(milliseconds: 700),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            // alignment: Alignment.centerLeft,
                                            child: WelcomePage()));
                                  },
                                  textColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
