// To parse this JSON data, do
//
//     final memberDetail2 = memberDetail2FromJson(jsonString);

import 'dart:convert';

MemberDetail2 memberDetail2FromJson(String str) =>
    MemberDetail2.fromJson(json.decode(str));

String memberDetail2ToJson(MemberDetail2 data) => json.encode(data.toJson());

class MemberDetail2 {
  MemberDetail2({
    this.idMember,
    this.namaview,
    this.pasangan,
    this.nama,
    this.namaAlias,
    this.email,
    this.noHp,
    this.jk,
    this.status,
    this.verifikasi,
    this.verifikasiKode,
    this.kodeVerifikasi,
    this.alamat,
    this.tglRegistrasi,
    this.tglLahir,
    this.idNegara,
    this.tempatLahir,
    this.noKtp,
    this.noKk,
    this.marga,
    this.parompuon,
    this.sektor,
    this.wilayah,
    this.pendidikan,
    this.konsentrasi,
    this.pekerjaan,
    this.keahlian,
    this.source,
    this.kota,
    this.title,
    this.gelar,
    this.idMarga,
    this.idParompuon,
    this.idSektor,
    this.idWilayah,
    this.idSource,
    this.generation,
    this.idGeneration,
    this.idGenerasi,
    this.idTitle,
    this.idGelar,
    this.idPendidikan,
    this.idKonsentrasi,
    this.idPekerjaan,
    this.idKeahlian,
    this.anggota,
  });

  String idMember;
  String namaview;
  String pasangan;
  String nama;
  String namaAlias;
  String email;
  String noHp;
  int jk;
  int status;
  String verifikasi;
  int verifikasiKode;
  String kodeVerifikasi;
  List<Alamat> alamat;
  String tglRegistrasi;
  DateTime tglLahir;
  int idNegara;
  String tempatLahir;
  String noKtp;
  String noKk;
  String marga;
  String parompuon;
  String sektor;
  String wilayah;
  String pendidikan;
  String konsentrasi;
  String pekerjaan;
  String keahlian;
  String source;
  int kota;
  String title;
  String gelar;
  String idMarga;
  int idParompuon;
  int idSektor;
  int idWilayah;
  int idSource;
  String generation;
  String idGeneration;
  int idGenerasi;
  int idTitle;
  int idGelar;
  int idPendidikan;
  int idKonsentrasi;
  int idPekerjaan;
  int idKeahlian;
  List<Anggota> anggota;

  factory MemberDetail2.fromJson(Map<String, dynamic> json) => MemberDetail2(
        idMember: json["id_member"],
        namaview: json["namaview"],
        pasangan: json["pasangan"],
        nama: json["nama"],
        namaAlias: json["nama_alias"],
        email: json["email"],
        noHp: json["no_hp"],
        jk: json["jk"],
        status: json["status"],
        verifikasi: json["verifikasi"],
        verifikasiKode: json["verifikasi_kode"],
        kodeVerifikasi: json["kode_verifikasi"],
        alamat:
            List<Alamat>.from(json["alamat"].map((x) => Alamat.fromJson(x))),
        tglRegistrasi: json["tgl_registrasi"],
        tglLahir: json["tgl_lahir"],
        idNegara: json["id_negara"],
        tempatLahir: json["tempat_lahir"],
        noKtp: json["no_ktp"],
        noKk: json["no_kk"],
        marga: json["marga"],
        parompuon: json["parompuon"],
        sektor: json["sektor"],
        wilayah: json["wilayah"],
        pendidikan: json["pendidikan"],
        konsentrasi: json["konsentrasi"],
        pekerjaan: json["pekerjaan"],
        keahlian: json["keahlian"],
        source: json["source"],
        kota: json["kota"],
        title: json["title"],
        gelar: json["gelar"],
        idMarga: json["id_marga"],
        idParompuon: json["id_parompuon"],
        idSektor: json["id_sektor"],
        idWilayah: json["id_wilayah"],
        idSource: json["id_source"],
        generation: json["generation"],
        idGeneration: json["id_generation"],
        idGenerasi: json["id_generasi"],
        idTitle: json["id_title"],
        idGelar: json["id_gelar"],
        idPendidikan: json["id_pendidikan"],
        idKonsentrasi: json["id_konsentrasi"],
        idPekerjaan: json["id_pekerjaan"],
        idKeahlian: json["id_keahlian"],
        anggota:
            List<Anggota>.from(json["anggota"].map((x) => Anggota.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_member": idMember,
        "namaview": namaview,
        "pasangan": pasangan,
        "nama": nama,
        "nama_alias": namaAlias,
        "email": email,
        "no_hp": noHp,
        "jk": jk,
        "status": status,
        "verifikasi": verifikasi,
        "verifikasi_kode": verifikasiKode,
        "kode_verifikasi": kodeVerifikasi,
        "alamat": List<dynamic>.from(alamat.map((x) => x.toJson())),
        "tgl_registrasi": tglRegistrasi,
        "tgl_lahir": tglLahir,
        "id_negara": idNegara,
        "tempat_lahir": tempatLahir,
        "no_ktp": noKtp,
        "no_kk": noKk,
        "marga": marga,
        "parompuon": parompuon,
        "sektor": sektor,
        "wilayah": wilayah,
        "pendidikan": pendidikan,
        "konsentrasi": konsentrasi,
        "pekerjaan": pekerjaan,
        "keahlian": keahlian,
        "source": source,
        "kota": kota,
        "title": title,
        "gelar": gelar,
        "id_marga": idMarga,
        "id_parompuon": idParompuon,
        "id_sektor": idSektor,
        "id_wilayah": idWilayah,
        "id_source": idSource,
        "generation": generation,
        "id_generation": idGeneration,
        "id_generasi": idGenerasi,
        "id_title": idTitle,
        "id_gelar": idGelar,
        "id_pendidikan": idPendidikan,
        "id_konsentrasi": idKonsentrasi,
        "id_pekerjaan": idPekerjaan,
        "id_keahlian": idKeahlian,
        "anggota": List<dynamic>.from(anggota.map((x) => x.toJson())),
      };
}

class Alamat {
  Alamat({
    this.alamatLengkap,
    this.idAlamat,
    this.keteranganAlamat,
  });

  String alamatLengkap;
  int idAlamat;
  String keteranganAlamat;

  factory Alamat.fromJson(Map<String, dynamic> json) => Alamat(
        alamatLengkap: json["alamat_lengkap"],
        idAlamat: json["id_alamat"],
        keteranganAlamat: json["keterangan_alamat"],
      );

  Map<String, dynamic> toJson() => {
        "alamat_lengkap": alamatLengkap,
        "id_alamat": idAlamat,
        "keterangan_alamat": keteranganAlamat,
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
  String noKtp;
  String tanggalLahir;
  String noHp;
  String status;
  String idContact;
  String idChild;
  String jk;

  factory Anggota.fromJson(Map<String, dynamic> json) => Anggota(
        nama: json["Nama"],
        noKtp: json["no_ktp"],
        tanggalLahir: json["tanggal_lahir"],
        noHp: json["no_hp"],
        status: json["status"],
        idContact: json["id_contact"],
        idChild: json["id_child"],
        jk: json["jk"],
      );

  Map<String, dynamic> toJson() => {
        "Nama": nama,
        "no_ktp": noKtp,
        "tanggal_lahir": tanggalLahir,
        "no_hp": noHp,
        "status": status,
        "id_contact": idContact,
        "id_child": idChild,
        "jk": jk,
      };
}
