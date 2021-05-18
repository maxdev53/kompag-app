// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_login_register_ui/models/informasi.dart';
// import 'package:html/dom.dart';
// import 'package:html/parser.dart' show parse;

class DetailNewsScreen extends StatefulWidget {
  final String kategori;
  final Informasi informasi;
  const DetailNewsScreen(
      {Key key, @required this.kategori, @required this.informasi})
      : super(key: key);

  @override
  _DetailNewsScreenState createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  @override
  void initState() {
    super.initState();
    // var document = parse(widget.informasi.konten);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'tagImage${widget.informasi}.kategori',
                    child: Image.network(
                      'https://apikompag.maxproitsolution.com/kompagapi/public/storage/' +
                          widget.informasi.gambarCover,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.informasi.judul,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Icon(Icons.person),
                            Text(
                              widget.informasi.user,
                              style: TextStyle(fontSize: 12.0),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(Icons.date_range),
                            Text(
                              widget.informasi.tglBuat,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Html(data: widget.informasi.konten)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
