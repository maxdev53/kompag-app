import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/helpers/storage.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

// import 'package:zefyr/zefyr.dart';

class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  String saving;
  Function(String) callBack;
  MyAppBar({
    Key key,
    this.saving,
    this.callBack,
    this.color,
    this.title,
    this.values,
    // @required this.formKey
  }) : super(key: key);
  final Color color;
  final Widget title;
  // final GlobalKey<FormState> formKey;
  final TextEditingController values;

  @override
  _MyAppBarState createState() => _MyAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {

  // showStatus(,Function callback){

  // }
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: widget.title,
        // titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Palette.primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24.0,
          ),
          // icon: Image(
          //   width: 24,
          //   color: Colors.white,
          //   image: Svg('assets/images/back_arrow.svg'),
          // ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () async {
              // widget.callBack('ya');
              setState(() {
                // _loading = true;
              });
              print(widget.values.text);
              if (widget.values.text == null ||
                  widget.values.text.isEmpty ||
                  widget.values.text == '') {
                showToast('Status tidak boleh kosong',
                    context: context,
                    position: StyledToastPosition.bottom,
                    animation: StyledToastAnimation.scale);
              } else {
                String token = await getStorageData('token');

                Map<String, String> headers = {
                  // "Content-Type": "application/json",
                  // 'Accept': 'application/json',
                  'Authorization': 'Bearer $token'
                };
                var url = Uri.parse(
                    'https://maxproitsolution.com/apikompag/api/anggota/status');
                var response = await http.post(url, headers: headers, body: {
                  'status': widget.values.text,
                  // 'no_hp': noHpRegisterController.text,
                  // 'email': emailRegisterController.text,
                });

                print(response.body);
                // widget.callBack("no");

                setState(() {
                  // _loading = false;
                });
              }

              // return null;
              // String statusText = widget.status;
              // var textMarkdown = notusMarkdown.encode(statusText);
              // print();
              // return widget.values.text;
            },
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    // color: Colors.grey,
                    width: 70.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    // child: Text("Post"),
                  ),
                ),
                Positioned(
                  left: 30,
                  bottom: 19.0,
                  child: Container(color: Colors.white, child: Text('Post')),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
