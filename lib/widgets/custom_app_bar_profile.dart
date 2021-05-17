import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/config/palette.dart';

class CustomAppBarProfile extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, 250);
  const CustomAppBarProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: myClipper(),
      child: Container(
        // color: Palette.primaryColor,
        decoration: BoxDecoration(color: Palette.primaryColor, boxShadow: [
          BoxShadow(color: Colors.red, blurRadius: 20, offset: Offset(0, 0))
        ]),
        child: Container(
          margin: EdgeInsets.only(left: 4, top: 4),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu),
                    color: Colors.white,
                    iconSize: 28,
                    onPressed: () {},
                  ),
                  Divider(color: Colors.white)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class myClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(0, size.height - 70);
    p.lineTo(size.width, 70);
    p.lineTo(size.width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
