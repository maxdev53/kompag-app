// To parse this JSON data, do
//
//     final members = membersFromJson(jsonString);

import 'dart:convert';

List<Member> membersFromJson(String str) => List<Member>.from(json.decode(str).map((x) => Member.fromJson(x)));

String membersToJson(List<Member> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Member {
    Member({
        this.idMember,
        this.kodeVerifikasi,
        this.nama,
        this.email,
        this.noHp,
        this.jk,
        this.verifikasi,
        this.tglRegistrasi,
        this.marga,
        this.parompuon,
        this.sektor,
        this.wilayah,
        this.generation,
        this.pasangan,
        this.anggota,
    });

    String idMember;
    String kodeVerifikasi;
    String nama;
    Email email;
    String noHp;
    String jk;
    String verifikasi;
    String tglRegistrasi;
    String marga;
    String parompuon;
    String sektor;
    String wilayah;
    String generation;
    String pasangan;
    List<Anggota> anggota;

    factory Member.fromJson(Map<String, dynamic> json) => Member(
        idMember: json["id_member"],
        kodeVerifikasi: json["kode_verifikasi"],
        nama: json["nama"],
        email: emailValues.map[json["email"]],
        noHp: json["no_hp"],
        jk: json["jk"],
        verifikasi: json["verifikasi"],
        tglRegistrasi: json["tgl_registrasi"],
        marga: json["marga"],
        parompuon: json["parompuon"],
        sektor: json["sektor"],
        wilayah: json["wilayah"],
        generation: json["generation"],
        pasangan: json["pasangan"],
        anggota: List<Anggota>.from(json["anggota"].map((x) => Anggota.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_member": idMember,
        "kode_verifikasi": kodeVerifikasi,
        "nama": nama,
        "email": emailValues.reverse[email],
        "no_hp": noHp,
        "jk": jk,
        "verifikasi": verifikasi,
        "tgl_registrasi": tglRegistrasi,
        "marga": marga,
        "parompuon": parompuon,
        "sektor": sektor,
        "wilayah": wilayah,
        "generation": generation,
        "pasangan": pasangan,
        "anggota": List<dynamic>.from(anggota.map((x) => x.toJson())),
    };
}

class Anggota {
    Anggota({
        this.nama,
        this.noKtp,
        this.tanggalLahir,
        this.noHp,
        this.status,
        this.idContact,
        this.idChild,
        this.jk,
    });

    String nama;
    Email noKtp;
    TanggalLahir tanggalLahir;
    String noHp;
    Status status;
    String idContact;
    String idChild;
    String jk;

    factory Anggota.fromJson(Map<String, dynamic> json) => Anggota(
        nama: json["Nama"],
        noKtp: emailValues.map[json["no_ktp"]],
        tanggalLahir: tanggalLahirValues.map[json["tanggal_lahir"]],
        noHp: json["no_hp"],
        status: statusValues.map[json["status"]],
        idContact: json["id_contact"],
        idChild: json["id_child"],
        jk: json["jk"],
    );

    Map<String, dynamic> toJson() => {
        "Nama": nama,
        "no_ktp": emailValues.reverse[noKtp],
        "tanggal_lahir": tanggalLahirValues.reverse[tanggalLahir],
        "no_hp": noHp,
        "status": statusValues.reverse[status],
        "id_contact": idContact,
        "id_child": idChild,
        "jk": jk,
    };
}

enum Jk { PEREMPUAN, LAKI_LAKI }

final jkValues = EnumValues({
    "Laki - Laki": Jk.LAKI_LAKI,
    "Perempuan": Jk.PEREMPUAN
});

enum Email { BELUM_DILENGKAPI, THE_3201044908740003 }

final emailValues = EnumValues({
    "Belum dilengkapi": Email.BELUM_DILENGKAPI,
    "3201044908740003": Email.THE_3201044908740003
});

enum Status { PASANGAN, ANAK }

final statusValues = EnumValues({
    "Anak": Status.ANAK,
    "Pasangan": Status.PASANGAN
});

enum TanggalLahir { BELUM_DILENGKAPI, SELASA_07_OKTOBER_1986, JUMAT_09_AGUSTUS_1974 }

final tanggalLahirValues = EnumValues({
    "Belum dilengkapi": TanggalLahir.BELUM_DILENGKAPI,
    "Jumat, 09 Agustus 1974": TanggalLahir.JUMAT_09_AGUSTUS_1974,
    "Selasa, 07 Oktober 1986": TanggalLahir.SELASA_07_OKTOBER_1986
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
