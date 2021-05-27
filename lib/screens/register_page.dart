import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/screens/register/filter_register_screen.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';

import '../constants.dart';
import '../widgets/widget.dart';
import 'login/login_screen.dart';
import 'screen.dart';

class RegisterPage extends StatefulWidget {
  String nama = '';
  String id = '';
  bool haveName;

  RegisterPage({Key key, this.nama, this.id, this.haveName}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

TextEditingController namaRegisterController = new TextEditingController();
TextEditingController emailRegisterController = new TextEditingController();
TextEditingController noHpRegisterController = new TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  bool _saving = false;
  String _memberNama;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  // final _formKey3 = GlobalKey<FormState>();
  // final _formKey =
  Future<dynamic> registerAkun() async {
    setState(() {
      _saving = true;
    });
    var url = Uri.parse(
        'https://maxproitsolution.com/apikompag/api/anggota/registrasi/pertama');

    var response = await http.post(url, body: {
      'member_id': widget.id,
      'no_hp': noHpRegisterController.text,
    });
    String _namaPendaftar =
        widget.nama == '' ? namaRegisterController.text : widget.nama;
    //  == null
    //     ? 'user'
    //     : namaRegisterController.text;

    var statusCode = response.statusCode;
    setState(() {
      _saving = false;
    });

    switch (statusCode) {
      case 400:
        showToast('Gagal , data tidak lengkap ! ',
            position: StyledToastPosition.bottom,
            context: context,
            duration: Duration(seconds: 1),
            animation: StyledToastAnimation.scale);
        break;
      case 406:
        showToast('Gagal , gangguan server',
            position: StyledToastPosition.bottom,
            context: context,
            duration: Duration(seconds: 1),
            animation: StyledToastAnimation.scale);
        break;
      case 200:
        showToast('Berhasil , menunggu persetujuan admin ',
            position: StyledToastPosition.bottom,
            context: context,
            duration: Duration(seconds: 2),
            animation: StyledToastAnimation.scale);
        namaRegisterController.clear();
        noHpRegisterController.clear();
        Timer(Duration(seconds: 3), () {
          FlutterOpenWhatsapp.sendSingleMessage("628111755827",
              "Salam sejahtera%0aSaya telah mengajukan pembuatan akun%0aNama : $_namaPendaftar%0aTerimakasih");
        });
        Timer(Duration(seconds: 1), () {
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
        // setState(() {
        //   _namaPendaftar = '';
        // });
        break;
      case 201:
        showToast('Anda sudah mendaftar ,Menunggu persetujuan admin ',
            position: StyledToastPosition.center,
            context: context,
            duration: Duration(seconds: 3),
            animation: StyledToastAnimation.fade);
        Timer(Duration(seconds: 1), () => {}
            // Navigator.push(
            // context,
            // CupertinoPageRoute(
            //   builder: (context) => WelcomePage(
            //       // nama: widget.nama,
            //       // noHp: noHpRegisterController.text),
            //       ),
            // ),
            // ),
            );
        // namaRegisterController.clear();
        // noHpRegisterController.clear();

        break;

      case 202:
        showToast('Akun sudah disetujui,silahkan login',
            position: StyledToastPosition.bottom,
            context: context,
            duration: Duration(seconds: 1),
            animation: StyledToastAnimation.scale);
        namaRegisterController.clear();
        noHpRegisterController.clear();

        Timer(
            Duration(seconds: 2),
            () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => WelcomePage(
                      // nama: widget.nama,
                      // noHp: noHpRegisterController.text),
                      ),
                )));
        break;
      default:
    }
  }

  Future<dynamic> registerMemberAkun(String name, String memberId) async {
    var url = Uri.parse(
        'https://maxproitsolution.com/apikompag/api/anggota/registrasi/pertama');

    var response = await http.post(url, body: {
      'member_id': memberId,
      'no_hp': noHpRegisterController.text,
    });
    // String _namaPendaftar = namaRegisterController.text == null
    //     ? name
    //     : namaRegisterController.text;

    var statusCode = response.statusCode;

    return statusCode;
  }

  Future<dynamic> registerMember() async {
    setState(() {
      _saving = true;
    });
    var url = Uri.parse(
        'https://maxproitsolution.com/apikompag/api/anggota/self-store-member');
    // String token = await storage.read(key: 'token');
    var phone3 = noHpRegisterController.text;
    var phone2 = phone3.substring(0, 2);
    var phone0 = phone3.substring(0, 1);
    var phone1 = phone3.substring(1);
    var phone;
    if (phone2 == '62') {
      phone = phone3;
    } else {
      if (phone0 == '0') {
        phone = '62' + phone1;
      } else {
        phone = '62' + phone3;
      }
    }
    var response = await http.post(
      url,
      body: {
        'name': namaRegisterController.text,
        'email': emailRegisterController.text,
        'simcard_contact': phone,
      },
    );

    var statusCode = response.statusCode;
    setState(() {
      _saving = false;
    });

    String idMember;
    if (statusCode == 200) {
      var body = json.decode(response.body);
      idMember = body['data_member']['id_org_member'];
    }

    switch (statusCode) {
      case 400:
        showToast('Data sudah ada ',
            position: StyledToastPosition.center,
            context: context,
            duration: Duration(seconds: 2),
            animation: StyledToastAnimation.fade);
        break;
      //   case 406:
      //     CoolAlert.show(
      //         title: "Kesalahan",
      //         context: context,
      //         type: CoolAlertType.error,
      //         text: "Nomer HP sudah terdaftar");
      //     break;
      case 200:
        showToast('Berhasil,diarahkan ke tahap selanjutnya',
            position: StyledToastPosition.bottom,
            context: context,
            duration: Duration(seconds: 1),
            animation: StyledToastAnimation.scale);
        setState(() {
          _memberNama = namaRegisterController.text;
        });

        new Timer(const Duration(seconds: 1), () {
          Navigator.push(
            context,
            PageTransition(
              duration: Duration(milliseconds: 700),
              type: PageTransitionType.fade,
              // alignment: Alignment.centerLeft,
              // child: RegisterPage(
              //   haveName: false,
              // ),
              child: FilterRegisterScreen(
                namaMember: _memberNama,
                idMember: idMember,
              ),
            ),
          );
          // Navigator.of(context).pushAndRemoveUntil(
          //     CupertinoPageRoute(
          //         builder: (context) => FilterRegisterScreen(
          //               namaMember: namaRegisterController.text,
          //               idMember: idMember,
          //             )),
          //     (route) => false);

          // );
        });
        // void createAkun() async {
        registerMemberAkun(namaRegisterController.text, idMember)
            .then((value) => {});
        // }
        namaRegisterController.clear();
        noHpRegisterController.clear();
        emailRegisterController.clear();

        break;

      default:
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.nama != '') {
      namaRegisterController.text = widget.nama;
    } else {
      namaRegisterController.text = '';
    }
    // namaRegisterController.text = widget.nama;
  }

  bool passwordVisibility = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // builder: EasyLoading.init(),
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
                            "Pendaftaran akun",
                            style: kHeadline,
                          ),
                          Text(
                            "dapatkan kemudahan & informasi menarik.",
                            style: kBodyText2,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          MyTextField(
                            formKey: _formKey,
                            enableInput: widget.haveName ? false : true,
                            hintText: 'Nama',
                            controller: namaRegisterController,
                            inputType: TextInputType.name,
                          ),
                          // SizedBox(
                          //   height: 2.0,
                          // ),
                          // MyTextField(
                          //   hintText: 'Email',
                          //   controller: emailRegisterController,
                          //   inputType: TextInputType.emailAddress,
                          // ),
                          MyTextField(
                            formKey: _formKey1,

                            // noHp: noHpRegisterController.text,
                            hintText: 'No HP',
                            controller: noHpRegisterController,
                            inputType: TextInputType.phone,
                          ),
                          Text(
                            "*Nomor harus diawali dengan angka 0",
                            style: TextStyle(
                              color: Colors.grey[350],
                              fontSize: 14.0,
                            ),
                          ),

                          widget.haveName
                              ? Text('')
                              : MyTextField(
                                  formKey: _formKey2,

                                  // noHp: noHpRegisterController.text,
                                  hintText: 'Email',
                                  controller: emailRegisterController,
                                  inputType: TextInputType.emailAddress,
                                ),
                          // MyPasswordField(
                          //   isPasswordVisible: passwordVisibility,
                          //   onTap: () {
                          //     setState(() {
                          //       passwordVisibility = !passwordVisibility;
                          //     });
                          //   },
                          // )
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
                            namaRegisterController.clear();
                            noHpRegisterController.clear();
                            emailRegisterController.clear();
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Masuk',
                            style: kBodyText.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            namaRegisterController.clear();
                            noHpRegisterController.clear();
                            Navigator.push(
                                context,
                                PageTransition(
                                    duration: Duration(milliseconds: 1000),
                                    type: PageTransitionType.scale,
                                    // alignment: Alignment.centerLeft,
                                    child: WelcomePage(
                                        // haveName: false,
                                        )));
                          },
                          child: Text(
                            'Halaman utama',
                            style: kBodyText.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.all(6.0),
                      child: MyTextButton(
                        borderColor: Colors.white,
                        buttonName:
                            widget.haveName ? 'Registrasi pertama' : 'Daftar',
                        onTap: () async {
                          // print('tap daftar');
                          if (widget.haveName) {
                            if (_formKey1.currentState.validate()) {
                              await registerAkun();
                            }
                          } else {
                            if (_formKey.currentState.validate() &&
                                _formKey1.currentState.validate() &&
                                _formKey2.currentState.validate()) {
                              await registerMember();
                            }
                          }
                        },
                        bgColor: Colors.black,
                        textColor: Colors.white,
                      ),
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
