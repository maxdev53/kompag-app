import 'package:bottom_loader/bottom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/Models/member.dart';
import 'package:flutter_login_register_ui/screens/screen.dart';
import 'package:flutter_login_register_ui/screens/welcome_page.dart';
import 'package:flutter_login_register_ui/widgets/my_text_button.dart';
import 'package:flutter_login_register_ui/widgets/my_text_field.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../constants.dart';

class ListUser extends StatefulWidget {
  // final data;
  List<Member> members;

  // _ListUserState(this.data);
  ListUser({Key key, this.members}) : super(key: key);

  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: kBackgroundColor,
      //   elevation: 0,
      //   // leading: IconButton(
      //   //   onPressed: () {
      //   //     Navigator.pop(context);
      //   //   },
      //   //   icon: Image(
      //   //     width: 24,
      //   //     color: Colors.white,
      //   //     image: Svg('assets/images/back_arrow.svg'),
      //   //   ),
      //   // ),
      // ),
      body: SafeArea(
        //to make page scrollable
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hasil pencarian",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 28.0),
                            ),
                            SizedBox(
                              height: 4,
                            ),

                            // SizedBox(
                            //   height: 14,
                            // ),

                            Container(
                              child: Container(
                                color: Colors.white,
                                margin: EdgeInsets.only(top: 24.0),
                                // color: Colors.black,
                                height: 500.0,
                                width: 400.0,
                                child: ListView.builder(
                                    itemCount: null == widget.members
                                        ? 0
                                        : widget.members.length,
                                    itemBuilder: (context, index) {
                                      Member member = widget.members[index];
                                      return ListTile(
                                        leading: CircleAvatar(
                                          foregroundColor: Colors.white,
                                          radius: 25,
                                          backgroundImage:
                                              member.jk == 'Perempuan'
                                                  ? AssetImage(
                                                      'assets/images/women.png')
                                                  : AssetImage(
                                                      'assets/images/man.png'),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  RegisterPage(
                                                nama: member.nama,
                                                id: member.idMember,
                                                haveName: true,
                                              ),
                                            ),
                                          );
                                        },
                                        hoverColor: Colors.black,
                                        selected: true,
                                        focusColor: Colors.black,
                                        isThreeLine: true,
                                        title: Text(
                                          member.nama,
                                          style: kTitleText,
                                        ),
                                        subtitle: Text(
                                          'Wilayah :${member.wilayah}\nSektor: ${member.sektor}',
                                          style: kDescriptionText,
                                        ),
                                        trailing: Icon(
                                          Icons.keyboard_arrow_right,
                                          color: Colors.black,
                                        ),
                                        dense: true,
                                      );
                                    }),
                              ),
                            ),
                            // Text('members', style: kBodyText2)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tidak ada data yang dicari ?"),
                          InkWell(
                            onTap: () {
                              print("Register Tapped");
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      duration: Duration(milliseconds: 700),
                                      type: PageTransitionType
                                          .leftToRightWithFade,
                                      // alignment: Alignment.centerLeft,
                                      child: RegisterPage(
                                        haveName: false,
                                      )));
                            },
                            child: Text(
                              " Daftar",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: EdgeInsets.all(6.0),
                      child: MyTextButton(
                          buttonName: 'Kembali',
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    duration: Duration(milliseconds: 700),
                                    type: PageTransitionType.rightToLeft,
                                    // alignment: Alignment.center,
                                    // alignment: Alignment.centerLeft,
                                    child: CekDataPage(
                                        // members: members,
                                        )));
                          },
                          bgColor: Colors.black,
                          textColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
