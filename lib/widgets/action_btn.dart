//Now i'm going to make a custom button for the different action like the comment button, share ...
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/models/services.dart';
import 'package:flutter_login_register_ui/screens/status/comment_screen.dart';
import 'package:page_transition/page_transition.dart';

class ActionButtonWidget extends StatefulWidget {
  ActionButtonWidget(
      {Key key,
      this.icon,
      this.actionTitle,
      this.iconColor,
      @required this.statusID,
      this.addLike,
      this.liked})
      : super(key: key);
  final IconData icon;
  final bool liked;
  final int statusID;
  final String actionTitle;
  final Color iconColor;
  final Function addLike;

  @override
  _ActionButtonWidgetState createState() => _ActionButtonWidgetState();
}

class _ActionButtonWidgetState extends State<ActionButtonWidget> {
  bool _liked = true;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton.icon(
        onPressed: () async {
          print(widget.statusID);
          if (widget.actionTitle == "Reply") {
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 400),
                    type: PageTransitionType.bottomToTop,
                    // alignment: Alignment.centerLeft,
                    child: CommentStatusScreen(
                      statusId: widget.statusID,
                    )));
          } else if (widget.actionTitle == "Like") {
            // bool res = await Services.postLike(widget.statusID);
            // print(res);
            this.widget.addLike();
            if (widget.liked && _liked) {
              // print("delete like");
              bool res = await Services.deleteLike(widget.statusID);
            } else if (widget.liked && !_liked) {
              bool res = await Services.postLike(widget.statusID);
            } else if (!widget.liked && _liked) {
              // print("add like");
              bool res = await Services.postLike(widget.statusID);
              print(res);
            } else {
              // print("delete like else");
              bool res = await Services.deleteLike(widget.statusID);
            }

            // print(this.widget.liked);
            setState(
              () {
                // this.widget.liked ?
                _liked = !_liked;
                // print(_liked);
                // if (!this.widget.liked) {
                //   _liked = true;
                // } else {
                //   _liked = false;
                // }
              },
            );
          }
        },
        icon: Icon(
          widget.icon,
          color: widget.iconColor,
        ),
        label: Text(
          widget.actionTitle,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

//the button wil take 3 parameter : the icon , the action title and the color of the icon
Widget actionButton(IconData icon, String actionTitle, Color iconColor) {
  return Expanded(
    child: FlatButton.icon(
      onPressed: () {
        // print(actionTitle);
        //  Navigator.push(
        //           contex,
        //           PageTransition(
        //               duration: Duration(milliseconds: 700),
        //               type: PageTransitionType.leftToRightWithFade,
        //               // alignment: Alignment.centerLeft,
        //               child: WelcomePage()));
      },
      icon: Icon(
        icon,
        color: iconColor,
      ),
      label: Text(
        actionTitle,
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    ),
  );
}
