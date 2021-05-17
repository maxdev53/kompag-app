import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/main.dart';
import 'package:flutter_login_register_ui/screens/register_akun.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../widgets/widget.dart';
import '../constants.dart';
import 'login/login_screen.dart';
import 'screen.dart';
import 'package:http/http.dart' as http;

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
  Future<dynamic> registerAkun() async {
    var url = Uri.parse(
        'https://apikompag.maxproitsolution.com/api/anggota/registrasi/pertama');

    var response = await http.post(url, body: {
      'member_id': widget.id,
      'no_hp': noHpRegisterController.text,
    });
    String _namaPendaftar = namaRegisterController.text == null
        ? 'user'
        : namaRegisterController.text;
    FlutterOpenWhatsapp.sendSingleMessage("628111755827",
        "Salam sejahtera  %0a Saya telah mengajukan pembuatan akun%0a atas nama $_namaPendaftar  %0a terimakasih");

    var statusCode = response.statusCode;

    switch (statusCode) {
      case 400:
        CoolAlert.show(
            title: "Data tidak lengkap",
            context: context,
            type: CoolAlertType.error,
            text: "Harap isi nomer HP");
        break;
      case 406:
        CoolAlert.show(
            title: "Kesalahan",
            context: context,
            type: CoolAlertType.error,
            text: "Nomer HP sudah terdaftar");
        break;
      case 200:
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Registrasi pertama berhasil",
          onConfirmBtnTap: () => {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => WelcomePage(
                      // nama: widget.nama,
                      // noHp: noHpRegisterController.text),
                      ),
                ))
          },
        );
        namaRegisterController.clear();
        noHpRegisterController.clear();

        break;
      case 201:
        CoolAlert.show(
          title: "anda sudah membuat pengajuan akun",
          context: context,
          type: CoolAlertType.info,
          text: "Menunggu persetujuan admin",
          onConfirmBtnTap: () => {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => WelcomePage(
                      // nama: widget.nama,
                      // noHp: noHpRegisterController.text),
                      ),
                ))
          },
        );
        namaRegisterController.clear();
        noHpRegisterController.clear();

        break;

      case 202:
        CoolAlert.show(
            title: "akun anda sudah dibuat",
            context: context,
            type: CoolAlertType.success,
            text: "Silahkan login");
        namaRegisterController.clear();
        noHpRegisterController.clear();
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => WelcomePage(
                  // nama: widget.nama,
                  // noHp: noHpRegisterController.text),
                  ),
            ));
        break;
      default:
    }
  }

  Future<dynamic> registerMember() async {
    var url = Uri.parse(
        'https://apikompag.maxproitsolution.com/api/anggota/self-store-member');
    // String token = await storage.read(key: 'token');
    var response = await http.post(
      url,
      body: {
        'name': namaRegisterController.text,
        'email': emailRegisterController.text,
        'no_hp': noHpRegisterController.text,
      },
      // headers: {
      //   'Content-Type' : 'application/json',
      //   ''
      // }
    );

    print(response.body);
    // String _namaPendaftar = namaRegisterController.text == null
    // ? 'user'
    //     : namaRegisterController.text;
    // FlutterOpenWhatsapp.sendSingleMessage("628111755827",
    //     "Salam sejahtera  %0a Saya telah mengajukan pembuatan akun%0a atas nama $_namaPendaftar  %0a terimakasih");

    var statusCode = response.statusCode;

    switch (statusCode) {
      case 400:
        CoolAlert.show(
            title: "Data tidak lengkap",
            context: context,
            type: CoolAlertType.error,
            text: "Harap isi nomer HP");
        break;
      case 406:
        CoolAlert.show(
            title: "Kesalahan",
            context: context,
            type: CoolAlertType.error,
            text: "Nomer HP sudah terdaftar");
        break;
      case 200:
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Pendaftaran berhasil",
          onConfirmBtnTap: () => {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CekDataPage(
                      // nama: widget.nama,
                      // noHp: noHpRegisterController.text),
                      ),
                ))
          },
        );
        namaRegisterController.clear();
        noHpRegisterController.clear();
        emailRegisterController.clear();

        break;
      case 201:
        CoolAlert.show(
          title: "anda sudah membuat pengajuan akun",
          context: context,
          type: CoolAlertType.info,
          text: "Menunggu persetujuan admin",
          onConfirmBtnTap: () => {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => WelcomePage(
                      // nama: widget.nama,
                      // noHp: noHpRegisterController.text),
                      ),
                ))
          },
        );
        namaRegisterController.clear();
        noHpRegisterController.clear();

        break;

      case 202:
        CoolAlert.show(
            title: "akun anda sudah dibuat",
            context: context,
            type: CoolAlertType.success,
            text: "Silahkan login");
        namaRegisterController.clear();
        noHpRegisterController.clear();
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => WelcomePage(
                  // nama: widget.nama,
                  // noHp: noHpRegisterController.text),
                  ),
            ));
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    namaRegisterController.text = widget.nama;
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
                            enableInput: widget.haveName ? false : true,
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
                            // noHp: noHpRegisterController.text,
                            hintText: 'No HP',
                            controller: noHpRegisterController,
                            inputType: TextInputType.phone,
                          ),
                          widget.haveName
                              ? Text('')
                              : MyTextField(
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
                      height: 20,
                    ),
                    MyTextButton(
                      buttonName:
                          widget.haveName ? 'Registrasi pertama' : 'Daftar',
                      onTap: () async {
                        print('tap daftar');
                        widget.haveName
                            ? await registerAkun()
                            : await registerMember();
                      },
                      bgColor: Colors.black,
                      textColor: Colors.white,
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