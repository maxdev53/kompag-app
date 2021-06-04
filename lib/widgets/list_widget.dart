import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/models/informasi.dart';

Widget listWidget(Informasi item) {
  return Card(
    elevation: 2.0,
    margin: EdgeInsets.only(bottom: 20.0),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: 'tagImage$item.kategori',
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://maxproitsolution.com/apikompag/api/public/storage/' +
                            item.gambarCover,
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.judul,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.label,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    Text(
                      item.kategori,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.0,
                ),
                Row(
                  children: [
                    Icon(Icons.person),
                    Text(
                      item.user,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    // SizedBox(
                    //   height: 5.0,
                    // ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.date_range),
                    Text(
                      item.tglBuat,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
