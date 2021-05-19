import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_login_register_ui/models/informasi.dart';
import 'package:flutter_login_register_ui/models/member_detail.dart';
import 'package:flutter_login_register_ui/models/services.dart';
// import 'package:flutter_login_register_ui/screens/screens.dart';
// import 'package:flutter_login_register_ui/screens/welcome_page.dart';
import 'package:flutter_login_register_ui/services/shared_pref.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
// import 'package:flutter_login_register_ui/config/styles.dart';
import 'package:flutter_login_register_ui/data/data.dart';
import 'package:flutter_login_register_ui/widgets/widgets.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPref sharedPref = SharedPref();
  String _nama = '';
  String _memberId;
  String _noHp;
  String _mobileNumber;
  // List<SimCard> _simCard = <SimCard>[];
  MemberDetail _memberDetailSave = MemberDetail();
  List<Informasi> _informasis;
  bool _loading;

  // void requestPhone() async {
  //   var data = await MobileNumber.requestPhonePermission;
  //   // print(data);
  //   // return data;
  // }

  // Future<dynamic> checkPermissionPhone() async {
  //   var data = await MobileNumber.hasPhonePermission;
  //   print(data);
  //   if (data) {
  //     final String phoneNumber = await MobileNumber.mobileNumber;
  //     // print(phoneNumber);
  //     setState(() {
  //       _noHp = phoneNumber;
  //     });
  //   } else {
  //     requestPhone();
  //   }
  //   // print(data);
  //   // return data;
  // }

  // @override
  Future<String> getDataLogin() async {
    String nama = await storage.read(key: 'nama');
    String memberId = await storage.read(key: 'memberId');
    setState(() {
      _nama = nama;
      _memberId = memberId;
    });

    return nama;
  }

  // Future<String> get() async {
  //   String nama = await storage.read(key: 'nama');
  //   setState(() {
  //     _nama = nama;
  //   });
  //   return nama;
  // }
  void getInformasi() async {
    Services.getInformasi().then((informasis) {
      setState(() {
        _loading = false;
        _informasis = informasis;
      });
    });
  }

  @override
  void initState() {
    getDataLogin();
    _loading = true;

    getInformasi();
    // requestPhone();
    // checkPermissionPhone();
    // if
    // sharedPref.save('memberDetail', _memberDetailSave);
    // print(_member);
    super.initState();
    
  }

  
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Apa kamu yakin?'),
              content: Text('ingin keluar dari Aplikasi'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Batal'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('Ya'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            );
          },
        ) ??
        false;
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // List<Widget> widgets = _simCard
    //     .map((SimCard sim) => Text(
    //         'Sim Card Number: (${sim.countryPhonePrefix}) - ${sim.number}\nCarrier Name: ${sim.carrierName}\nCountry Iso: ${sim.countryIso}\nDisplay Name: ${sim.displayName}\nSim Slot Index: ${sim.slotIndex}\n\n'))
    //     .toList();
    // return Column(children: widgets);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: CustomAppBar( color: Palette.primaryColor),
        body: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [
            _buildHeader(screenHeight),
            _buildPosTips(screenHeight),
            _buildDetail(screenHeight),
            // _buildHotPromo(screenHeight),
          ],
        ),
        // drawer: Drawer(
        //   // child: ListView(
        //   //   children: <Widget>[
        //   //     UserAccountsDrawerHeader(
        //   //       accountName: Text('hi'),
        //   //       accountEmail: Text('hello'),
        //   //     )
        //   //   ],
        //   // ),
        // ),
      ),
    );
  }

// List<Widget> widgets = _informasis.map((name) => new Text(name.gambarIsi)).toList();
  // List<Informasi> _informasis;
  Widget gambar() {
    
    return new Column(
        // Informasis informasis = informasis;
        children: _informasis
            .map((item) => new Container(
                width: 100.00,
                height: 100.00,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(item.gambarCover), fit: BoxFit.cover),

                  // image: new DecorationImage(
                  // image: DecorationImage(image: NetworkImage('item.gambarCover')),
                  // fit: BoxFit.fitHeight,
                  // ),
                )))
            .toList());
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
            Row(
              children: <Widget>[
                Text(
                  'Hi , $_nama',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Selamat datang di aplikasi Kompag',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600),
                ),
                Text('...',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     FlatButton.icon(
                //         padding: const EdgeInsets.symmetric(
                //             vertical: 10.0, horizontal: 20.0),
                //         onPressed: () async {
                //           // final prefs = await SharedPreferences.getInstance();

              
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPosTips(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        // color: Colors.orange,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Yang akan datang',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Container(
                  // padding: EdgeInsets.only(right: 8),
                  // padding: EdgeInsets.all(30),
                  // margin: EdgeInsets.all(4),
                  child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: postTips
                          .map(
                            (e) => InkWell(
                              onTap: () {
                                print(e['link']);
                              },
                              child: Column(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    e.keys.first,
                                    height: screenHeight * 0.12,
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.015,
                                  ),
                                  Text(
                                    e.values.first,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList()),
                )),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHotPromo(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        // color: Colors.orange,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Info terbaru',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Container(
                height: 300.0,
                width: 400.0,
                // padding: EdgeInsets.only(right: 8),
                // padding: EdgeInsets.all(30),
                // margin: EdgeInsets.all(4),
                child: ListView.builder(
                    // widget.usernames.length != null ? widget.usernames.length : 0;
                    itemCount: _loading ? 0 : _informasis.length,
                    itemBuilder: (context, index) {
                      Informasi informasi = _informasis[index];
                      return ListTile(
                        title: Text(informasi.judul),
                        // subtitle: Text(informasi.konten),
                      );
                    }),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            // Column(children: widgets)
            // fillCards();
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildDetail(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        padding: EdgeInsets.all(10.0),
        // color: Colors.blue,
        height: screenHeight * 0.20,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe49f9f), Palette.primaryColor],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(
              'assets/images/hand.png',
              width: 150.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Banyak manfaat',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  'Dalam satu\ngenggaman.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  maxLines: 2,
                  // textAlign: TextAlign.center,
                ),
              ],
            )
            // SvgPicture.asset('assets/images/undraw_Content3.svg')
          ],
        ),
      ),
    );
  }
}
