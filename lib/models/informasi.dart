// To parse this JSON data, do
//
//     final informasi = informasiFromJson(jsonString);

import 'dart:convert';

List<Informasi> informasiFromJson(String str) => List<Informasi>.from(json.decode(str).map((x) => Informasi.fromJson(x)));

String informasiToJson(List<Informasi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Informasi {
    Informasi({
        this.idInformasi,
        this.gambarCover,
        this.gambarIsi,
        this.judul,
        this.slug,
        this.konten,
        this.kategori,
        this.userId,
        this.tglBuat,
        this.status,
        this.tags,
        this.jumlahKomentar,
    });

    int idInformasi;
    String gambarCover;
    String gambarIsi;
    String judul;
    String slug;
    String konten;
    String kategori;
    String userId;
    DateTime tglBuat;
    int status;
    List<Tag> tags;
    int jumlahKomentar;

    factory Informasi.fromJson(Map<String, dynamic> json) => Informasi(
        idInformasi: json["id_informasi"],
        gambarCover: json["gambar_cover"],
        gambarIsi: json["gambar_isi"],
        judul: json["judul"],
        slug: json["slug"],
        konten: json["konten"],
        kategori: json["kategori"],
        userId: json["user_id"],
        tglBuat: DateTime.parse(json["tgl_buat"]),
        status: json["status"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        jumlahKomentar: json["jumlah_komentar"],
    );

    Map<String, dynamic> toJson() => {
        "id_informasi": idInformasi,
        "gambar_cover": gambarCover,
        "gambar_isi": gambarIsi,
        "judul": judul,
        "slug": slug,
        "konten": konten,
        "kategori": kategori,
        "user_id": userId,
        "tgl_buat": tglBuat.toIso8601String(),
        "status": status,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "jumlah_komentar": jumlahKomentar,
    };
}

class Tag {
    Tag({
        this.id,
        this.nama,
        this.slug,
        this.createdAt,
        this.updatedAt,
        this.pivot,
    });

    int id;
    String nama;
    String slug;
    DateTime createdAt;
    DateTime updatedAt;
    Pivot pivot;

    factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        nama: json["nama"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "slug": slug,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
    };
}

class Pivot {
    Pivot({
        this.informasiId,
        this.tagId,
    });

    int informasiId;
    int tagId;

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        informasiId: json["informasi_id"],
        tagId: json["tag_id"],
    );

    Map<String, dynamic> toJson() => {
        "informasi_id": informasiId,
        "tag_id": tagId,
    };
}
