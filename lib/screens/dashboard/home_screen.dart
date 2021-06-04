import 'dart:math';

import 'package:colour/colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
// import 'package:flutter_login_register_ui/config/styles.dart';
import 'package:flutter_login_register_ui/data/data.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_login_register_ui/models/informasi.dart';
import 'package:flutter_login_register_ui/models/latest_status.dart';
import 'package:flutter_login_register_ui/models/member_detail.dart';
import 'package:flutter_login_register_ui/models/services.dart';
import 'package:flutter_login_register_ui/screens/dashboard/news_screen.dart';
import 'package:flutter_login_register_ui/screens/status/post_status_screen.dart';
// import 'package:flutter_login_register_ui/screens/screens.dart';
// import 'package:flutter_login_register_ui/screens/welcome_page.dart';
import 'package:flutter_login_register_ui/services/shared_pref.dart';
import 'package:flutter_login_register_ui/widgets/feed_box.dart';
import 'package:flutter_login_register_ui/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:pop_bottom_menu/pop_bottom_menu.dart';

// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class HomeScreen extends StatefulWidget {
  Function decrementStatus;
  int latestStatus;
  int decrement = 0;

  HomeScreen({Key key, this.latestStatus, this.decrement, this.decrementStatus})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _statusForm = new GlobalKey<FormState>();
  SharedPref sharedPref = SharedPref();
  String _nama = '';
  String _photo = '';
  // bool _loading = false;
  List<LatestStatus> _latestStatus;
  String _memberId;
  String _noHp;
  String _mobileNumber;
  // List<SimCard> _simCard = <SimCard>[];
  MemberDetail _memberDetailSave = MemberDetail();
  List<Informasi> _informasis;
  bool _loading = false;

  List<String> avatarUrl = [
    "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80",
    "https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80",
    "https://images.unsplash.com/photo-1525879000488-bff3b1c387cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
  ];
  List<String> storyUrl = [
    "https://images.unsplash.com/photo-1600055882386-5d18b02a0d51?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=621&q=80",
    "https://images.unsplash.com/photo-1600174297956-c6d4d9998f14?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1600008646149-eb8835bd979d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=666&q=80",
    "https://images.unsplash.com/photo-1502920313556-c0bbbcd00403?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=967&q=80",
  ];

  // @override
  Future<String> getDataLogin() async {
    String nama = await storage.read(key: 'nama');
    String memberId = await storage.read(key: 'memberId');
    String photo = await storage.read(key: 'photo');
    print(photo);
    setState(() {
      _nama = nama;
      _memberId = memberId;
      _photo = photo;
    });

    return nama;
  }

  Future<List> getStatus() async {
    setState(() {
      _loading = true;
    });

    List data = await Services.getLatestStatus();
    // print(data.length);

    // print(_dataInformasiUndangan.length);
    setState(() {
      _loading = false;
      _latestStatus = data;
    });
    // print(data);
    return data;
  }

  // Future<String> get() async {
  //   String nama = await storage.read(key: 'nama');
  //   setState(() {
  //     _nama = nama;
  //   });
  //   return nama;
  // }

  @override
  void initState() {
    // widget.decrement ==
    getDataLogin();
    getStatus();
    _loading = true;

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
              title: Text('Apakah yakin?'),
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
    // print("build " + widget.latestStatus.toString());
    int updatedStatusLength = (widget.latestStatus != null)
        ? _latestStatus.length - 1
        : (_latestStatus == null)
            ? 3
            : _latestStatus.length;

    final screenHeight = MediaQuery.of(context).size.height;
    // List<Widget> widgets = _simCard
    //     .map((SimCard sim) => Text(
    //         'Sim Card Number: (${sim.countryPhonePrefix}) - ${sim.number}\nCarrier Name: ${sim.carrierName}\nCountry Iso: ${sim.countryIso}\nDisplay Name: ${sim.displayName}\nSim Slot Index: ${sim.slotIndex}\n\n'))
    //     .toList();
    // return Column(children: widgets);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colour("#D7DBDD"),
        appBar: CustomAppBar(color: Palette.primaryColor),
        // body: Column(
        //   children: <Widget>[
        //     Container(
        //       width: double.infinity,
        //       decoration: BoxDecoration(
        //           color: Colors.black,
        //           borderRadius: BorderRadius.circular(12.0)),
        //       child: Padding(
        //         padding:
        //             const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        //         child: Row(
        //           children: [
        //             CircleAvatar(
        //               radius: 25.0,
        //               backgroundImage: AssetImage("assets/images/man.png"),
        //             ),
        //           ],
        //         ),
        //       ),
        //     )
        //   ],
        // ),

        body: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [
            _buildHeader(screenHeight),
            _buildTextBar(screenHeight),
            _buildTimeLine(screenHeight)
            // _buildPosTips(screenHeight),
            // _buildDetail(screenHeight),
            // _buildExpandedBottom(screenHeight),
            // _buildHotPromo(screenHeight),
          ],
        ),
        drawer: Drawer(
            // child: ListView(
            //   children: <Widget>[
            //     UserAccountsDrawerHeader(
            //       accountName: Text('hi'),
            //       accountEmail: Text('hello'),
            //     )
            //   ],
            // ),
            ),
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

  SliverList _buildTimeLine(double screenHeight) {
    // print(widget.latestStatus.length);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, index) {
          // var contain = _latestStatus[index].likes.where((element) => element.anggota == _latestStatus[index].nama);
          // print(_latestStatus);
          return _loading
              ? Container(
                  height: 300.0,
                  width: 200.0,
                  child: PKCardListSkeleton(
                    isCircularImage: false,
                    isBottomLinesActive: true,
                    length: 8,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child:
                      // FeedBoxWidget(avatarUrl: ,)
                      FeedBoxWidget( 
                    liked: _latestStatus[index].liked,
                    ownStatus:
                        _latestStatus[index].nama == _nama ? true : false,
                    listStatus: _latestStatus,
                    avatarUrl: avatarUrl[0],
                    userPhoto: _latestStatus[index].userPhoto,
                    photo: _latestStatus[index].photo == null
                        ? 'kosong'
                        : _latestStatus[index].photo,
                    // liked: contain.isEmpty ? false : true,
                    userName: _latestStatus[index].nama,
                    date: _latestStatus[index].waktu,
                    contentText: _latestStatus[index].status,
                    contentImg: '',
                    like: _latestStatus[index].countLike,
                    comment: _latestStatus[index].countComment,
                    id: _latestStatus[index].id,
                  ),
                );
          // return feedBox(avatarUrl[index], "Doctor code", "6 min",
          //     "I just wrote something", "");
        },
        childCount: _loading ? 3 : _latestStatus.length,
      ),
    );
    // SliverList(
    //   child: Padding(
    //     padding: EdgeInsets.all(10.0),
    //     // child: ListView.builder(
    //     //   itemCount: 3,
    //     //   itemBuilder: (context, index) {
    //     //     return Flexible(
    //     //       child: InkWell(
    //     //           onTap: () => {
    //     //                 // print(index),
    //     //                 // Navigator.push(
    //     //                 //     context,
    //     //                 //     MaterialPageRoute(
    //     //                 //         builder: (context) => DetailNewsScreen(
    //     //                 //             kategori: _latestStatus[index]
    //     //                 //                 .kategori,
    //     //                 //             informasi:
    //     //                 //                 _latestStatus[index])))
    //     //               },
    //     //           child: Column(
    //     //             children: [
    //     //               // feedBox(
    //     //               //     avatarUrl[0],
    //     //               //     _latestStatus[index].nama,
    //     //               //     _latestStatus[index].waktu,
    //     //               //     _latestStatus[index].status,
    //     //               //     '')

    //     //               feedBox(avatarUrl[0], "Doctor code", "6 min",
    //     //                   "I just wrote something", ""),
    //     //               feedBox(avatarUrl[1], "Joseph Joestar", "6 min",
    //     //                   "It's pretty good I like it", storyUrl[2]),
    //     //               feedBox(avatarUrl[2], "Giorno giovana", "Yesterday",
    //     //                   "I'm Giorno Giovana and I have a Dream", storyUrl[1]),
    //     //             ],
    //     //           )),
    //     //     );
    //     //   },
  }

  SliverToBoxAdapter _buildTextBar(double screenHeight) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, right: 10.0, left: 10.0),
      child: Column(
        children: <Widget>[
          Container(
            // color: Colors.transparent,
            // padding: EdgeInsets.all(20.0),
            height: 72.0,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colour("#F7F9F9"),
                borderRadius: BorderRadius.circular(16.0)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32.0,
                    backgroundImage: _photo != ''
                        ? NetworkImage(
                            'https://maxproitsolution.com/apikompag/api/public/storage/' +
                                _photo,
                          )
                        : AssetImage(
                            'assets/images/man.png',
                          ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              duration: Duration(milliseconds: 500),
                              type: PageTransitionType.leftToRight,
                              child: PostStatusScreen(
                                nama: _nama,
                              )),
                        );
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 8.0),
                          // height: 200.0,
                          // width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Apa yanga anda pikirkan ?",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16.0),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 18.0),
                                child: Icon(
                                  Icons.share,
                                ),
                              )
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
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
                      fontSize: 20.0,
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
                      fontSize: 26.0,
                      fontWeight: FontWeight.normal),
                ),
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

  SliverToBoxAdapter _buildExpandedBottom(double screenHeight) {
    return SliverToBoxAdapter(
        child: Container(
            height: screenHeight * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: NewsScreen(),
            )));
  }
}
