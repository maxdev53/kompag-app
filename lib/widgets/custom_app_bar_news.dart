import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';

class CustomAppBarNews extends StatefulWidget with PreferredSizeWidget {
  const CustomAppBarNews(
      {Key key, @required this.tabController, @required this.tabList})
      : super(key: key);

  final TabController tabController;
  final List tabList;
  @override
  _CustomAppBarNewsState createState() => _CustomAppBarNewsState();
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarNewsState extends State<CustomAppBarNews>
    with SingleTickerProviderStateMixin {
  // List<Tab> _tabList = [
  //   Tab(child: Text('Terbaru')),
  //   Tab(child: Text('Berita')),
  //   Tab(child: Text('Undangan')),
  //   Tab(child: Text('Pengumuman')),
  //   // Tab(child: Text('Terbaru')),
  // ];
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
    return AppBar(
      toolbarHeight: 130.0,
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
      leading: Builder(
        builder: (BuildContext context) {
          return Container();
          // return IconButton(
          //   icon: const Icon(Icons.menu),
          //   color: Colors.white,
          //   iconSize: 28.0,
          //   onPressed: () {
          //     print('navigation Bar');
          //     Scaffold.of(context).openDrawer();
          //   },
          //   tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          // );
        },
      ),
      centerTitle: true,
      title: Text(
        "Pusat informasi",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
      bottom: PreferredSize(
        child: TabBar(
          // unselectedLabelColor: Colors.grey[350],
          indicatorColor: Colors.black,
          labelColor: Colors.white,
          isScrollable: true,
          controller: widget.tabController,
          tabs: widget.tabList,
        ),
        preferredSize: Size.fromHeight(60.0),
      ),
      actions: [
        //   IconButton(
        //     icon: const Icon(Icons.notifications_none),
        //     color: Colors.white,
        //     iconSize: 28.0,
        //     onPressed: () {
        //       print('navigation Bar');
        //     },
        //   ),
      ],
    );
  }
}
