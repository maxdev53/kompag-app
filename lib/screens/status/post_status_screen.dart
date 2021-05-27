import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/helpers/storage.dart';
import 'package:flutter_login_register_ui/screens/dashboard/bottom_nav_screen.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';

// _Teststate _globalState = new _TestState();

class PostStatusScreen extends StatefulWidget {
  PostStatusScreen({Key key, this.nama}) : super(key: key);

  final String nama;

  @override
  _PostStatusScreenState createState() => _PostStatusScreenState();
}

class _PostStatusScreenState extends State<PostStatusScreen> {
  bool _loading = false;
  final _statusFormKey = new GlobalKey<FormState>();
  //

  // ZefyrController _statusController;
  TextEditingController _statusController = new TextEditingController();
  // FocusNode _focusNode;
  // final _statusForm = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // print(_loading);
    // final document = _loadDocument();
    // _statusController = ZefyrController(document);
    // _focusNode = FocusNode();
  }

  // NotusDocument _loadDocument() {
  //   final Delta delta = Delta()..insert("\n");

  //   return NotusDocument.fromDelta(delta);
  // }

  @override
  Widget build(BuildContext context) {
    var widgetHeaderUser = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
            minRadius: 20.0,
            maxRadius: 35.0,
            backgroundImage: AssetImage(
              'assets/images/man.png',
            )),
        SizedBox(
          width: 4.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.nama}",
              style: TextStyle(fontSize: 20.0),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // margin: EdgeInsets.all(12.0),
                  // padding: EdgeInsets.all(3.0),
                  child: Row(
                    children: [
                      Icon(Icons.people_alt_outlined),
                      Text("Anggota")
                    ],
                  ),
                )
              ],
            )
            // Text("${widget.nama}"),
          ],
        )
      ],
    );
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Text("buat status", style: TextStyle(color: Colors.white)),
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
                  if (_statusController.text == '') {
                    showToast('Status tidak boleh kosong',
                        context: context,
                        position: StyledToastPosition.bottom,
                        animation: StyledToastAnimation.scale);
                  } else {
                    setState(() {
                      _loading = true;
                    });
                    String token = await getStorageData('token');

                    Map<String, String> headers = {
                      // "Content-Type": "application/json",
                      // 'Accept': 'application/json',
                      'Authorization': 'Bearer $token'
                    };
                    var url = Uri.parse(
                        'https://maxproitsolution.com/apikompag/api/anggota/status');
                    var response =
                        await http.post(url, headers: headers, body: {
                      'status': _statusController.text,
                      // 'no_hp': noHpRegisterController.text,
                      // 'email': emailRegisterController.text,
                    });

                    setState(() {
                      _loading = false;
                    });

                    if (response.statusCode == 200) {
                      showToast('Status berhasil dibuat',
                          duration: Duration(seconds: 2),
                          context: context,
                          position: StyledToastPosition.bottom,
                          animation: StyledToastAnimation.scale);
                      // Navigator.of(context).pop();

                      Navigator.push(
                        context,
                        PageTransition(
                          duration: Duration(milliseconds: 500),
                          type: PageTransitionType.rightToLeft,
                          child: BottomNavScreen(
                            pageIndex: 0,
                            // members: members,
                          ),
                        ),
                      );
                    }
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
                      child:
                          Container(color: Colors.white, child: Text('Post')),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              widgetHeaderUser,
              SizedBox(
                height: 14.0,
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                height: 300.0,
                width: double.infinity,
                child: Form(
                  key: _statusFormKey,
                  child: TextFormField(
                    validator: (value) {
                      print(value);
                      if (value == '') {
                        return 'tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: _statusController,
                    decoration: InputDecoration(
                      border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //     color: Colors.black,
                      //     width: 2.0,
                      //   ),
                      // ),
                      // filled: true,
                      // fillColor: Colors.white,
                    ),
                    // controller: _statusController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 10,
                  ),
                ),
                // child: ZefyrScaffold(
                //   child: ZefyrEditor(
                //     // padding: EdgeInsets.all(6.0),
                //     controller: _statusController,
                //     focusNode: _focusNode,
                //   ),
                // ),
              ),
              // MyAppBar(
              // saving: _loading,
              // callBack: callBack(_loading),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
