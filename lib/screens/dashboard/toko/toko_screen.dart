import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/data/dataIcon.dart';
// import 'package:flutter_login_register_ui/config/styles.dart';
// import 'package:flutter_login_register_ui/screens/dashboard/main.dart';
// import 'package:flutter_login_register_ui/screens/dashboard/toko/detail_screen.dart';
import 'package:flutter_login_register_ui/widgets/widgets.dart';
// import 'package:page_transition/page_transition.dart';

class BarangScreen extends StatefulWidget {
  BarangScreen({Key key}) : super(key: key);

  @override
  _BarangScreenState createState() => _BarangScreenState();
}

class _BarangScreenState extends State<BarangScreen> {
  int selectedCategoryIconIndex = 0;

  Widget _buildCategoryIcon(int index) {
    return Padding(
      padding: EdgeInsets.only(
        right: 30.0,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => {
              print('hi'),
              setState(() => {selectedCategoryIconIndex = index}),
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  height: 75.0,
                  width: 75.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(screenHeight),
          // SizedBox(height: screenHeight*0.4,),

          // _buildListBarang(screenHeight),
          _buildGreating(screenHeight),
          // _buildCategoryIcon(screenHeight)

        ],
      ),
    );
  }

  // SliverToBoxAdapter _buildCategoryIcon(double screenHeight) {
  //   return SliverToBoxAdapter(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         //  Container(
  //         //   height: 100.0,
  //         //   child: ListView.builder(
  //         //     physics: BouncingScrollPhysics(),
  //         //     padding: EdgeInsets.only(left: 20.0, top: 20.0),
  //         //     scrollDirection: Axis.horizontal,
  //         //     itemCount: categoryIcon.length,
  //         //     itemBuilder: (BuildContext context, int index) {
  //         //       return _buildCategoryIcon(index);
  //         //     },
  //         //   ),
  //         // ),
  //         Padding(padding: EdgeInsets.only(left: 20.0),
  //         child: Text("Populer",style: TextStyle(
  //           fontSize: 24.0,
  //           color: Colors.black54,
  //           fontWeight: FontWeight.bold
  //         ),),
  //         )
  //       ],
  //     ),
  //   );
  // }

  SliverToBoxAdapter _buildGreating(double screenHeight) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0),
            child: Text(
              'Kepuasan anda\nprioritas kami',
              style: TextStyle(
                  fontSize: 25.0,
                  // color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3.0),
            ),
          ),
          Container(
            height: 100.0,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(left: 20.0, top: 20.0),
              scrollDirection: Axis.horizontal,
              itemCount: categoryIcon.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildCategoryIcon(index);
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 20.0 , top: 20.0),
          child: Text("Populer",style: TextStyle(
            fontSize: 24.0,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),),
          )
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.only(
            // bottomLeft: Radius.circular(70.0),
            bottomRight: Radius.circular(200),
          ),
        ),
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
                  'Daftar toko',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600),
                ),
                Text('temukan apa yang anda butuhkan disini',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildListBarang(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height - 180.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(75.0),
          ),
        ),
        child: ListView(
          primary: false,
          padding: EdgeInsets.only(left: 25.0, right: 20.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 10.0,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height - 300.0,
                child: ListView(
                  children: <Widget>[
                    _buildBarangItem(
                        'assets/images/market.png', 'Toko A', '\Rp.100.000'),
                    _buildBarangItem('assets/images/barang/barang1.png',
                        'Toko B', '\Rp.100.000'),
                    _buildBarangItem('assets/images/barang/barang2.png',
                        'Toko C', '\Rp.100.000'),
                    _buildBarangItem('assets/images/barang/barang3.png',
                        'Toko D', '\Rp.100.000'),
                    _buildBarangItem('assets/images/barang/barang4.png',
                        'Toko E', '\Rp.100.000'),
                    _buildBarangItem('assets/images/barang/barang5.png',
                        'Toko F', '\Rp.100.000'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildBarangItem(String imgPath, String barangNama, String harga) {
  return Padding(
    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
    child: InkWell(
      onTap: () {
        // Get.to(() => DetailScreen());
        Get.toNamed('/toko/detail', arguments: barangNama);
        // Get.to(DetailScreen());
        print('navigation Bar');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                Hero(
                  tag: imgPath,
                  child: Image(
                    image: AssetImage(imgPath),
                    fit: BoxFit.cover,
                    height: 75.0,
                    width: 75.0,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      barangNama,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      harga,
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
            color: Colors.black,
          )
        ],
      ),
    ),
  );
  // SizedBox(
  //   height: MediaQuery.of(context).size.height * 0.04,
  // );
}
