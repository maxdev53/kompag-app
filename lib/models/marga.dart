// To parse this JSON data, do
//
//     final marga = margaFromJson(jsonString);

import 'dart:convert';

Marga margaFromJson(String str) => Marga.fromJson(json.decode(str));

String margaToJson(Marga data) => json.encode(data.toJson());

class Marga {
    Marga({
        this.data,
    });

    List<Datum> data;

    factory Marga.fromJson(Map<String, dynamic> json) => Marga(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.nama,
    });

    String id;
    String nama;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nama: json["nama"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
    };
}
