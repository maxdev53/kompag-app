import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../widgets/widget.dart';
import '../constants.dart';
import 'screen.dart';
import 'package:http/http.dart' as http;

class RegisterAkun extends StatefulWidget {
  String nama = '';
  String id = '';
  String noHp = '';

  RegisterAkun({Key key, this.nama, this.id, this.noHp}) : super(key: key);
  @override
  _RegisterAkunState createState() => _RegisterAkunState();
}

TextEditingController namaRegisterController = new TextEditingController();
// TextEditingController emailRegisterController = new TextEditingController();
TextEditingController noHpRegisterController = new TextEditingController();

class _RegisterAkunState extends State<RegisterAkun> {
  @override
  void initState() {
    super.initState();
    namaRegisterController.text = widget.nama;
    noHpRegisterController.text = widget.noHp;
  }

  final _formKey = GlobalKey<FormState>();

  bool passwordVisibility = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // builder: EasyLoading.init(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.white,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pendaftaran akun baru",
                            style: kHeadline,
                          ),
                          Text(
                            "Buat akunmu untuk menikmati fitur ini.",
                            style: kBodyText2,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          MyTextField(
                            formKey: GlobalKey<FormState>(),
                            enableInput: false,
                            hintText: 'Nama',
                            controller: namaRegisterController,
                            inputType: TextInputType.name,
                          ),
                          // MyTextField(
                          //   hintText: 'Email',
                          //   controller: emailRegisterController,
                          //   inputType: TextInputType.emailAddress,
                          // ),
                          MyTextField(
                            formKey: GlobalKey<FormState>(),
                            hintText: 'No HP',
                            enableInput: false,
                            controller: noHpRegisterController,
                            inputType: TextInputType.phone,
                          ),
                          MyPasswordField(
                            formKey: _formKey,
                            isPasswordVisible: passwordVisibility,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sudah punya akun? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Masuk',
                            style: kBodyText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      borderColor: Colors.white,
                      buttonName: 'Registrasi pertama',
                      onTap: () async {
                        var url = Uri.parse(
                            'https://maxproitsolution.com/apikompag/api/anggota/registrasi/pertama');
                        var response = await http.post(url, body: {
                          'member_id': widget.id,
                          'no_hp': noHpRegisterController.text,
                          // 'email': emailRegisterController.text,
                        });
                        if (response.statusCode == 200) {
                          showToast('registrasi Berhasil',
                              position: StyledToastPosition.bottom,
                              context: context,
                              duration: Duration(seconds: 1),
                              animation: StyledToastAnimation.scale);
                          Timer(
                              Duration(seconds: 2),
                              () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => SignInPage(),
                                    ),
                                  ));
                        }
                      },
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    )
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
