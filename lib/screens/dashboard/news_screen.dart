import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/widgets/custom_app_bar.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({Key key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    // print(_memberDetailLoad.nama);
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          // _buildHeader(screenHeight),
          // _buildStepperForm(screenHeight),
          // _buildStepperForm(screenHeight)
        ],
      ),
    );
  }
}