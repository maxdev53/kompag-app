import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
import 'package:flutter_login_register_ui/helpers/storage.dart';
import 'package:flutter_login_register_ui/models/latest_status.dart';
import 'package:flutter_login_register_ui/screens/dashboard/bottom_nav_screen.dart';
import 'package:flutter_login_register_ui/widgets/action_btn.dart';
import 'package:flutter_login_register_ui/widgets/sub_action_btn.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:pop_bottom_menu/pop_bottom_menu.dart';

//the feed box will have for parameters :
// the user name , the user avatar, the pub date, the content text and content img
class FeedBoxWidget extends StatefulWidget {
  const FeedBoxWidget(
      {Key key,
      this.avatarUrl,
      this.photo,
      this.userPhoto,
      this.userName,
      this.date,
      this.contentText,
      this.contentImg,
      this.like,
      this.comment,
      this.id,
      this.listStatus,
      this.ownStatus,
      @required this.liked})
      : super(key: key);
  final String avatarUrl;
  final List<LatestStatus> listStatus;
  final bool ownStatus;
  final String userName;
  final String date;
  final String photo;
  final String userPhoto;
  final bool liked;
  final String contentText;
  final String contentImg;
  final int like;
  // final bool liked;
  final int id;
  final int comment;

  @override
  _FeedBoxWidgetState createState() => _FeedBoxWidgetState();
}

class _FeedBoxWidgetState extends State<FeedBoxWidget> {
  // void statusUpdated(){

  // }
  bool _saving = false;
  String _name;
  String _nameOwnStatus;
  int _jumlahLike;
  bool _liked = true;

  Future<String> getName() async {
    String name = await getStorageData('nama');
    setState(() {
      _name = name;
    });
    return name;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _nameOwnStatus = widget.userName;
      _jumlahLike = widget.like;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _showBottomMenu() {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return PopBottomMenu(
            title: TitlePopBottomMenu(
              label: "Pilih tindakan",
            ),
            items: [
              ItemPopBottomMenu(
                onPressed: () => print("friend list"),
                label: "Edit",
                icon: Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
              ),
              ItemPopBottomMenu(
                onPressed: () async {
                  // _HomeS
                  setState(() {
                    _saving = true;
                  });
                  String token = await getStorageData('token');
                  Map<String, String> headers = {
                    // "Content-Type": "application/json",
                    // 'Accept': 'application/json',
                    'Authorization': 'Bearer $token'
                  };
                  var url = Uri.parse(
                      'https://maxproitsolution.com/apikompag/api/anggota/status/' +
                          widget.id.toString());
                  var response = await http.delete(url, headers: headers);
                  if (response.statusCode == 200) {
                    widget.listStatus
                        .removeWhere((element) => element.id == widget.id);
                    // print(widget.listStatus.length);
                    // HomeScreen(latestStatus: 1);
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 300),
                        type: PageTransitionType.fade,
                        child: BottomNavScreen(
                          pageIndex: 0,
                        ),
                      ),
                    );
                    setState(() {
                      _saving = false;
                    });
                    showToast('Status berhasil dihapus',
                        position: StyledToastPosition.center,
                        context: context,
                        duration: Duration(seconds: 3),
                        animation: StyledToastAnimation.fade);
                  }
                  setState(() {
                    _saving = false;
                  });

                  // print(response.body);
                },
                label: "Hapus",
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              ItemPopBottomMenu(
                // onPressed: () => print("mute"),
                label: "",
                // icon: Icon(
                //   Icons.linear_scale_sharp,
                //   color: Colors.grey,
                // ),
              ),
              // ItemPopBottomMenu(
              //   onPressed: () => print("unfollow"),
              //   label: "Unfollow",
              // ),
            ],
          );
        },
      );
    }

    var userNametxt = Text(
      widget.userName,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
    );
    return _saving
        ? Center(child: CircularProgressIndicator())
        : Container(
            margin: EdgeInsets.only(bottom: 20.0),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Palette.secondaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: widget.userPhoto != ""
                            ? NetworkImage(
                                'https://maxproitsolution.com/apikompag/api/public/storage/' +
                                    widget.userPhoto)
                            : AssetImage("assets/images/man.png"),
                        radius: 25.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userNametxt,
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              widget.date,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // mainAxisAlignment: MainAxisAlignment.end,
                      !widget.ownStatus
                          ? Text('')
                          : InkWell(
                              onTap: () => {_showBottomMenu()},
                              child: Icon(Icons.more_vert_rounded,
                                  size: 24.0, color: Colors.grey[900]),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                if (widget.contentText != "")
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Container(
                      margin: EdgeInsets.only(left: 4.0),
                      child: Text(
                        widget.contentText,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 8.0,
                ),
                if (widget.photo != "kosong")
                  Container(
                    padding: EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Image.network(
                        'https://maxproitsolution.com/apikompag/api/public/storage/' +
                            widget.photo),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // subActionButton(
                    //     Icons.thumb_up, "${widget.like}", Colors.blue, 14.0),
                    // subActionButton(Icons.comment, "${widget.comment} komentar",
                    //     Colors.grey, 14.0),
                    FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.thumb_up,
                        color: Colors.blue,
                        size: 14.0,
                      ),
                      label: Text(
                        "$_jumlahLike",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.comment,
                        color: Colors.grey,
                        size: 14.0,
                      ),
                      label: Text(
                        "${widget.comment} komentar",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                Divider(
                  height: 0.2,
                  thickness: 0.5,
                  color: Color(0xFF505050),
                ),
                // Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // children: [
                // ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // actionButton(Icons.thumb_up, "Like", Color(0xFF505050)),
                    // actionButton(Icons.comment, "Reply", Color(0xFF505050)),
                    // actionButton(Icons.record_voice_over_outlined, "Share",
                    //     Color(0xFF505050)),
                    ActionButtonWidget(
                        liked: widget.liked,
                        addLike: () {
                          setState(() {
                            // _liked ? _jumlahLike-- : _jumlahLike++;
                            (widget.liked && _liked)
                                ? _jumlahLike--
                                : (widget.liked && !_liked)
                                    ? _jumlahLike++
                                    : (!widget.liked && !_liked)
                                        ? _jumlahLike--
                                        : _jumlahLike++;

                            _liked = !_liked;
                            print(_liked);
                            // widget.liked = a;
                          });
                        },
                        statusID: widget.id,
                        icon: Icons.thumb_up,
                        actionTitle: "Like",
                        iconColor: (widget.liked && _liked)
                            ? Colors.blue
                            : (widget.liked && !_liked)
                                ? Color(0xFF505050)
                                : (!widget.liked && _liked)
                                    ? Color(0xFF505050)
                                    : Colors.blue),
                    ActionButtonWidget(
                        statusID: widget.id,
                        icon: Icons.comment,
                        actionTitle: "Reply",
                        iconColor: Color(0xFF505050)),
                    ActionButtonWidget(
                        statusID: widget.id,
                        icon: Icons.link,
                        actionTitle: "Share",
                        iconColor: Color(0xFF505050)),
                  ],
                ),
                Divider(
                  thickness: 0.5,
                  color: Color(0xFF505050),
                ),
              ],
            ),
          );
  }
}
