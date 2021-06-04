import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/models/comment.dart';
import 'package:flutter_login_register_ui/models/response/post_comment.dart';
import 'package:flutter_login_register_ui/models/services.dart';
import 'package:flutter_login_register_ui/screens/screens.dart';
import 'package:flutter_login_register_ui/widgets/widget.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

class CommentStatusScreen extends StatefulWidget {
  CommentStatusScreen({Key key, @required this.statusId}) : super(key: key);
  final int statusId;

  @override
  _CommentStatusScreenState createState() => _CommentStatusScreenState();
}

class _CommentStatusScreenState extends State<CommentStatusScreen> {
  TextEditingController statusController = new TextEditingController();
  TextEditingController namaController = new TextEditingController();

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

  List<Comment> _comment;
  PostCommentResponse _responseComment;
  bool _loading = false;
  bool _saving = false;

  addNewComment(PostCommentResponse newComment) {
    // for (final item in _comment) {
    var commentMap = {
      'komentar': newComment.comment,
      'anggota': 'user',
    };

    // _comment.addAll(json.decode(commentMap.toString()));
    // }
  }

  Future<List<Comment>> getComment() async {
    // print("status id ${widget.statusId}");
    setState(() {
      _loading = true;
    });
    print(widget.statusId);
    List<Comment> listComment = await Services.getComment(widget.statusId);

    setState(() {
      _loading = false;
      _comment = listComment;
    });

    return listComment;
  }

  @override
  void initState() {
    super.initState();
    getComment();
  }

  final statusFormKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Scaffold(
            backgroundColor: Palette.subBackgroundColor,
            appBar: AppBar(
              title:
                  Text("buat komentar", style: TextStyle(color: Colors.white)),
              backgroundColor: Palette.primaryColor,
              leading: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            duration: Duration(milliseconds: 400),
                            type: PageTransitionType.rightToLeft,
                            // alignment: Alignment.centerLeft,
                            child: BottomNavScreen(
                              pageIndex: 0,
                            )));
                  }),
            ),
            body: _loading
                ? Center(
                    child: PKCardListSkeleton(
                      isCircularImage: false,
                      isBottomLinesActive: true,
                      length: 4,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 4.0, top: 24.0),
                          height: 560.0,
                          child: ListView.builder(
                              itemCount: _comment.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0, bottom: 6.0, right: 2.0),
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(top: 4.0, bottom: 6.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 32.0,
                                          backgroundImage: AssetImage(
                                              "assets/images/man.png"),
                                        ),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        Container(
                                          height: 76.0,
                                          width: screenHeight * 0.4,
                                          // width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0, left: 8.0),
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _comment[index].anggota,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  height: 4.0,
                                                ),
                                                Text(_comment[index].komentar,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black)),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              bottom: 20.0, left: 12.0, right: 12.0),
                          child: Column(
                            children: [
                              MyTextField(
                                  controller: namaController,
                                  textIcon: IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.blue,
                                      size: 32.0,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        _saving = true;
                                        // _loading = true;
                                      });
                                      PostCommentResponse response =
                                          await Services.postComment(
                                              widget.statusId,
                                              namaController.text);
                                      setState(() {
                                        // _loading = false;
                                        _saving = false;
                                        _responseComment = response;
                                      });
                                      showToast('komentar ditambahkan',
                                          position: StyledToastPosition.bottom,
                                          context: context,
                                          duration: Duration(seconds: 4),
                                          animation:
                                              StyledToastAnimation.scale);
                                      // addNewComment(_responseComment);
                                      Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                              duration:
                                                  Duration(milliseconds: 400),
                                              type: PageTransitionType.fade,
                                              // alignment: Alignment.centerLeft,
                                              child: CommentStatusScreen(
                                                  statusId: widget.statusId)));
                                    },
                                    color: Colors.blue,
                                  ),
                                  withIcon: true,
                                  hintText: "ketik komentar",
                                  inputType: TextInputType.text,
                                  formKey: statusFormKey),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
      ),
    )

        // CustomScrollView(
        //   physics: ClampingScrollPhysics(),
        //   slivers: [
        //     _buildCommentListSection(screenHeight),
        //     _buildCommentSection(screenHeight)
        //   ],
        // ),
        ;
  }

  SliverToBoxAdapter _buildCommentListSection(double screenHeight) {
    return SliverToBoxAdapter(
        child: Container(
      padding: EdgeInsets.all(14.0),
      // width: 440.0,
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 32.0,
            backgroundImage: AssetImage("assets/images/man.png"),
          ),
          SizedBox(
            width: 4.0,
          ),
          Container(
            height: 76.0,
            width: screenHeight * 0.4,
            // width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mohamad Wahyudin",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text("Ini komentar",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black)),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class ListCommentarWidget extends StatelessWidget {
  const ListCommentarWidget({
    Key key,
    this.screenHeight,
    this.name,
    this.comment,
    this.waktu,
  }) : super(key: key);

  final double screenHeight;
  final String name;
  final String comment;
  final String waktu;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.0, bottom: 6.0),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 32.0,
            backgroundImage: AssetImage("assets/images/man.png"),
          ),
          SizedBox(
            width: 4.0,
          ),
          Container(
            height: 76.0,
            width: screenHeight * 0.4,
            // width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text("$comment",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
