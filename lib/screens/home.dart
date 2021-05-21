import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/auth/api.dart';
import 'package:flutter_login_register_ui/main.dart';
// import 'package:mobile_number/mobile_number.dart';
import '../constants.dart';
import '../screens/screen.dart';
import '../widgets/widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _nama;

  // @override
  Future<String> getName() async {
    String nama = await storage.read(key: 'nama');
    setState(() {
      _nama = nama;
    });
    return nama;
  }

  @override
  void initState() {
    getName();
   
    super.initState();
  }

  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Image(
                          image:
                              AssetImage('assets/images/team_illustration.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Hi,$_nama\n Selamat datang di KOMPAG",
                      style: kHeadline,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "Aplikasi perhimpunan organisasi marga , yang menyediakan berbagai kebutuhan organisasi",
                        style: kBodyText,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xff303437),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MyTextButton(
                        borderColor: Colors.white,

                        bgColor: Color(0xffd9ced6),
                        buttonName: 'Cek storage',
                        onTap: () async {
                          Map<String, String> allValues =
                              await storage.readAll();
                        },
                        textColor: Color(0xff303437),
                      ),
                    ),
                    Expanded(
                      child: MyTextButton(
                        borderColor: Colors.white,

                        bgColor: Colors.transparent,
                        buttonName: 'Keluar',
                        onTap: () async {
                          await storage.deleteAll();
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SignInPage(
                                keluar: true,
                              ),
                            ),
                          );
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
    );
  }
}

