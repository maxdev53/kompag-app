import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/models/informasi.dart';
import 'package:flutter_login_register_ui/models/services.dart';
import 'package:flutter_login_register_ui/screens/dashboard/news/detail_screen.dart';
import 'package:flutter_login_register_ui/widgets/custom_app_bar.dart';
import 'package:flutter_login_register_ui/widgets/custom_app_bar_news.dart';
import 'package:flutter_login_register_ui/widgets/list_widget.dart';
import 'package:flutter_login_register_ui/widgets/skeleton.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
// import 'screens/l';

class NewsScreen extends StatefulWidget {
  NewsScreen({Key key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {
  bool _saving = false;
  TabController _tabController;
  bool _isLoading = false;
  List<Informasi> _informasis;

  Future<List> getInformasi() async {
    List data = await Services.getInformasi();
    setState(() {
      _informasis = data;
      _isLoading = false;
    });
    // print(data);
    return data;
  }

  @override
  void initState() {
    _isLoading = true;
    getInformasi();
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Tab> _tabList = [
    Tab(child: Text('Terbaru')),
    Tab(child: Text('Berita')),
    Tab(child: Text('Undangan')),
    Tab(child: Text('Pengumuman')),
    // Tab(child: Text('Terbaru')),
  ];
  // TabController _tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: _tabList.length, vsync: this);
  // }

  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Palette.primaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: CustomAppBarNews(
          tabController: _tabController,
          tabList: _tabList,
        ),
      ),
      body: _isLoading
          ? PKCardListSkeleton(
              isCircularImage: false,
              isBottomLinesActive: true,
              length: 8,
            )
          : TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: _informasis.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () => {
                                // print(index),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailNewsScreen(
                                            kategori:
                                                _informasis[index].kategori,
                                            informasi: _informasis[index])))
                              },
                          child: listWidget(_informasis[index]));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(),
                )
              ],
            ),
      // body: ModalProgressHUD(
      //   inAsyncCall: _saving,
      //   child: CustomScrollView(
      //     physics: ClampingScrollPhysics(),
      //     slivers: <Widget>[
      //       // _buildHeader(screenHeight),
      //       // _buildChangePassword(screenHeight),
      //     ],
      //   ),
      // ),
    );
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
            // Row(
            //   children: <Widget>[
            //     Text(
            //       'Maxpos',
            //       style: const TextStyle(
            //           color: Colors.white,
            //           fontSize: 30.0,
            //           fontWeight: FontWeight.bold),
            //     )
            //   ],
            // ),
            SizedBox(
              height: screenHeight * 0.001,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Informasi',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600),
                ),
                Text('Daftar informasi terbaru',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
