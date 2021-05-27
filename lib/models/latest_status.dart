// To parse this JSON data, do
//
//     final LatestStatus = LatestStatusFromJson(jsonString);

import 'dart:convert';

List<LatestStatus> LatestStatusFromJson(String str) => List<LatestStatus>.from(json.decode(str).map((x) => LatestStatus.fromJson(x)));

String LatestStatusToJson(List<LatestStatus> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LatestStatus {
    LatestStatus({
        this.id,
        this.status,
        this.waktu,
        this.tglBuat,
        this.nama,
        this.likes,
        this.countLike,
        this.countComment,
    });

    int id;
    String status;
    String waktu;
    String tglBuat;
    String nama;
    List<Like> likes;
    int countLike;
    int countComment;

    factory LatestStatus.fromJson(Map<String, dynamic> json) => LatestStatus(
        id: json["id"],
        status: json["status"],
        waktu: json["waktu"],
        tglBuat: json["tgl_buat"],
        nama: json["nama"],
        likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
        countLike: json["count_like"],
        countComment: json["count_comment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "waktu": waktu,
        "tgl_buat": tglBuat,
        "nama": nama,
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "count_like": countLike,
        "count_comment": countComment,
    };
}

class Like {
    Like({
        this.anggota,
    });

    String anggota;

    factory Like.fromJson(Map<String, dynamic> json) => Like(
        anggota: json["anggota"],
    );

    Map<String, dynamic> toJson() => {
        "anggota": anggota,
    };
}
