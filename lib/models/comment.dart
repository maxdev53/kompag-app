// To parse this JSON data, do
//
//     final Comment = CommentFromJson(jsonString);

import 'dart:convert';

List<Comment> commentFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
    Comment({
        this.id,
        this.anggota,
        this.komentar,
        this.waktu,
        this.tglBuat,
    });

    int id;
    String anggota;
    String komentar;
    String waktu;
    String tglBuat;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        anggota: json["anggota"],
        komentar: json["komentar"],
        waktu: json["waktu"],
        tglBuat: json["tgl_buat"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "anggota": anggota,
        "komentar": komentar,
        "waktu": waktu,
        "tgl_buat": tglBuat,
    };
}
