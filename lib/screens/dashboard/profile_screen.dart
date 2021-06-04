import 'dart:convert';

import 'package:bottom_loader/bottom_loader.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_login_register_ui/main.dart';
import 'package:flutter_login_register_ui/models/detail_member.dart';
import 'package:flutter_login_register_ui/models/member_detail.dart';
import 'package:flutter_login_register_ui/models/services.dart';
import 'package:flutter_login_register_ui/screens/dashboard/bottom_nav_screen.dart';
import 'package:flutter_login_register_ui/services/shared_pref.dart';
import 'package:flutter_login_register_ui/widgets/skeleton.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_login_register_ui/components/rounded_input_field.dart';
import 'package:flutter_login_register_ui/config/palette.dart';
// import 'package:flutter_login_register_ui/config/styles.dart';
// import 'package:flutter_login_register_ui/widgets/custom_app_bar_profile.dart';
import 'package:flutter_login_register_ui/widgets/my_text_field.dart';
import 'package:flutter_login_register_ui/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilScreen extends StatefulWidget {
  ProfilScreen({Key key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();
  final _formKey6 = GlobalKey<FormState>();
  final _formKey7 = GlobalKey<FormState>();
  final _formKey8 = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController noHpController = new TextEditingController();
  TextEditingController namaController = new TextEditingController();
  TextEditingController tempatLahirController = new TextEditingController();
  TextEditingController tglLahirController = new TextEditingController();
  TextEditingController noKkController = new TextEditingController();
  TextEditingController noKtpController = new TextEditingController();
  List _marga;
  bool _isLoading = false;
  List _generasi;
  List _parompuon;
  List _wilayah;
  List _sektor;
  List _gelarDepan;
  List _gelarSarjana;
  List _pekerjaan;
  List _pendidikan;
  List _keahlian;
  List _konsentrasi;
  String margaId = '';
  String pekerjaanId;
  String pendidikanId;
  String konsentrasiId;
  String keahlianId;
  String titleId;
  String gelarId;
  String gelarDepanId;
  String sektorId;
  String parompuonId;
  String wilayahId;
  String generasiId;
  SharedPref sharedPref = SharedPref();
  MemberDetail _memberDetailLoad = MemberDetail();
  String namaMarga = '';
  String namaGenerasi = '';
  String namaParompuon = '';
  String namaWilayah = '';
  String namaGelar = '';
  String namaPekerjaan = '';
  String namaPendidikan = '';
  String namaKeahlian = '';
  String namaKonsentrasi = '';
  String namaTitle = '';
  String namaTempatLahir = '';
  String tglLahir;
  int jk;
  int status;
  String noHp;
  String email;

  void getMemberDetail() async {
    String memberId = await storage.read(key: 'memberId');
    //
    try {
      var response = await http.get(
          Uri.parse('https://maxproitsolution.com/apikompag/api/anggota/member/$memberId'));
// memberDetailFromJson(response.body);
      // print(response.body);
      // bl.close();
      var jsonData = memberDetailFromJson(response.body);
      setState(() {
        _isLoading = false;
        _memberDetailLoad = jsonData;
        namaController.text = _memberDetailLoad.nama;
        namaMarga = _memberDetailLoad.marga;
        // print(_memberDetailLoad.generation);
        namaGenerasi = _memberDetailLoad.generation;
        namaParompuon = _memberDetailLoad.parompuon;
        namaWilayah = _memberDetailLoad.wilayah;
        namaGelar = _memberDetailLoad.gelar;
        namaTitle = _memberDetailLoad.title;
        namaPekerjaan = _memberDetailLoad.pekerjaan;
        namaPendidikan = _memberDetailLoad.pendidikan;
        namaKeahlian = _memberDetailLoad.keahlian;
        namaKonsentrasi = _memberDetailLoad.konsentrasi;
        tempatLahirController.text = _memberDetailLoad.tempatLahir;
        noKkController.text = _memberDetailLoad.noKk;
        noKtpController.text = _memberDetailLoad.noKtp;
        noHpController.text = _memberDetailLoad.noHp;
        emailController.text = _memberDetailLoad.email;
        tglLahir = _memberDetailLoad.tglLahir;
        jk = _memberDetailLoad.jk;
        status = _memberDetailLoad.status;
      });
      // body: {'nama_member': keyword});
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString('detail_member', json.encode(response.body));

      // print(memberId);
      // SharedPref sharedPref = SharedPref();

      // storage.write(key: 'memberDetail', value: response.body);
      // print(response.statusCode);
      // if (response.statusCode == 200) {
      // sharedPref.save('memberDetail', response.body);

      // final MemberDetail memberDetail = memberDetailFromJson(response.body);
      // print("oke");
      // return response.body;
      // }
    } catch (e) {
      // return MemberDetail();
    }
  }

  loadSharedPrefs() {
    try {
      // MemberDetail memberDetail =
      // MemberDetail.fromJson(await sharedPref.read("detail_member"));
      // print(memberDetail);
      // var memberDetail = sharedPref.read("memberDetail");
      // final prefs = await SharedPreferences.getInstance();
      // json.decode(prefs.getString(key));
      // final jsonString = json.decode(prefs.getString('detail_member'));
      // print("jsonString $jsonString");

      // final memberDetail =
      // MemberDetail.fromJson(json.decode(prefs.getString('detail_member')));
      // MemberDetail memberDetail = MemberDetail.fromJson(jsonString);
      // print(memberDetail.nama);
      setState(() {
        // _memberDetailLoad =
        //     MemberDetail.fromJson(sharedPref.read('member_detail'));

        // print(namaController.text);
        namaController.text = _memberDetailLoad.nama;
        namaMarga = _memberDetailLoad.marga;
        // print(_memberDetailLoad.generation);
        namaGenerasi = _memberDetailLoad.generation;
        namaParompuon = _memberDetailLoad.parompuon;
        namaWilayah = _memberDetailLoad.wilayah;
        namaGelar = _memberDetailLoad.gelar;
        namaTitle = _memberDetailLoad.title;
        namaPekerjaan = _memberDetailLoad.pekerjaan;
        namaPendidikan = _memberDetailLoad.pendidikan;
        namaKeahlian = _memberDetailLoad.keahlian;
        namaKonsentrasi = _memberDetailLoad.konsentrasi;
        tempatLahirController.text = _memberDetailLoad.tempatLahir;
        noKkController.text = _memberDetailLoad.noKk;
        noKtpController.text = _memberDetailLoad.noKtp;
        noHpController.text = _memberDetailLoad.noHp;
        emailController.text = _memberDetailLoad.email;
        tglLahir = _memberDetailLoad.tglLahir;
        jk = _memberDetailLoad.jk;
        status = _memberDetailLoad.status;

        // tglLahirController = _memberDetailLoad.tglLahir;

        // margaId = _memberDetailLoad.marga;
      });
    } catch (Exception) {
      // do something
      // do something
    }
  }

  // int marId;
  // MemberDetail _memberDetail;
  // List<Marga> margaList = [];
  final String uri = 'http://apikompag.maxproitsolution.com/api';
  Future<String> getMarga() async {
    var res = await http.get(Uri.parse("$uri/statistik/select-marga"));
    var resBody = json.decode(res.body);

    setState(() {
      _marga = resBody['data'];
    });
    return 'success';
  }

  Future<String> getGenerasi() async {
    var res = await http.get(Uri.parse("$uri/statistik/select-generasi"));
    var resBody = json.decode(res.body);

    setState(() {
      _generasi = resBody['data'];
    });
    return 'success';
  }

  Future<String> getParompuon() async {
    var res = await http.get(Uri.parse("$uri/statistik/select-parompuon"));
    var resBody = json.decode(res.body);

    setState(() {
      _parompuon = resBody['data'];
    });
    return 'success';
  }

  Future<String> getWilayah() async {
    var res = await http.get(Uri.parse("$uri/statistik/select-wilayah"));
    var resBody = json.decode(res.body);

    setState(() {
      _wilayah = resBody['data'];
    });
    return 'success';
  }

  Future<String> getSektor() async {
    var res = await http.get(Uri.parse("$uri/statistik/select-sektor"));
    var resBody = json.decode(res.body);

    setState(() {
      _sektor = resBody['data'];
    });
    return 'success';
  }

  Future<String> getGelarDepan() async {
    var res = await http.get(Uri.parse("$uri/statistik/select-gelar"));
    var resBody = json.decode(res.body);

    setState(() {
      _gelarDepan = resBody['data'];
    });
    return 'success';
  }

  Future<String> getGelarSarjana() async {
    var res = await http.get(Uri.parse("$uri/statistik/select-title"));
    var resBody = json.decode(res.body);

    setState(() {
      _gelarSarjana = resBody['data'];
    });
    return 'success';
  }

  Future<String> getPekerjaan() async {
    var res = await http.get(Uri.parse("$uri/statistik/select-pekerjaan"));
    var resBody = json.decode(res.body);

    setState(() {
      _pekerjaan = resBody['data'];
    });
    return 'success';
  }

  Future<String> getPendidikan() async {
    var res = await http.get(Uri.parse("$uri/statistik/select-pendidikan"));
    var resBody = json.decode(res.body);

    setState(() {
      _pendidikan = resBody['data'];
    });
    return 'success';
  }

  Future<String> getKeahlian() async {
    var res = await http.get(Uri.parse("$uri/statistik/select-keahlian"));
    var resBody = json.decode(res.body);

    setState(() {
      _keahlian = resBody['data'];
    });
    return 'success';
  }

  Future<String> getKonsentrasi() async {
    var res = await http.get(Uri.parse("$uri/statistik/select-konsentrasi"));
    var resBody = json.decode(res.body);

    setState(() {
      _konsentrasi = resBody['data'];
    });
    return 'success';
  }

  @override
  void initState() {
    _isLoading = true;
    super.initState();
    getMarga();
    getGenerasi();
    getParompuon();
    getWilayah();
    getSektor();
    getGelarDepan();
    getGelarSarjana();
    getPekerjaan();
    getPendidikan();
    getKeahlian();
    getKonsentrasi();
    // loadSharedPrefs();
    // var bl = new BottomLoader(
    //   context,
    //   showLogs: true,
    //   isDismissible: false,
    // );
    // bl.style(
    //     // progressWidget: ,
    //     // messageTextStyle: ,
    //     message: 'mohon tunggu...',
    //     messageTextStyle: TextStyle(
    //       color: Colors.black,
    //       fontSize: 14.0,
    //       fontWeight: FontWeight.w600,
    //     ));
    // bl.display();
    getMemberDetail();
    // print(loadSharedPrefs());
    margaId = _memberDetailLoad.marga;
    // print("hi $_memberDetailLoad");

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    // print(_memberDetailLoad.nama);
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar(color: Palette.primaryColor),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(screenHeight),
          // _buildStepperForm(screenHeight),
          _buildStepperForm(screenHeight)
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildStepperForm(double screenHeight) {
    return SliverToBoxAdapter(
        child: _isLoading
            ? Row(
                children: [
                  Expanded(
                      child: SizedBox(
                    height: 550.0,
                    child: PKCardPageSkeleton(),
                  )),
                ],
              )
            : Row(
                children: <Widget>[
                  Expanded(
                      child: SizedBox(
                    height: 550.0,
                    child: CoolStepper(
                      config: const CoolStepperConfig(
                          nextText: 'selanjutnya',
                          backText: 'kembali',
                          stepText: 'form',
                          ofText: 'dari',
                          finalText: 'Selesai'),
                      onCompleted: () async {
                        print('hi');
                        String nama = namaController.text;
                        String noHp = noHpController.text;
                        String email = emailController.text;
                        String noKK = noKkController.text;
                        String noKTP = noKtpController.text;
                        var datatglLahir = tglLahir == null
                            ? _memberDetailLoad.tglLahir
                            : tglLahir;
                        String tempatLahir = tempatLahirController.text;
                        var idTitle = titleId == null
                            ? _memberDetailLoad.idTitle
                            : titleId;

                        var idGelar = gelarId == null
                            ? _memberDetailLoad.idGelar
                            : gelarId;

                        var idMarga = margaId == null
                            ? _memberDetailLoad.idMarga
                            : margaId;
                        var idGenerasi = generasiId == null
                            ? _memberDetailLoad.idGenerasi
                            : generasiId;
                        var idParompuon = parompuonId == null
                            ? _memberDetailLoad.idParompuon
                            : parompuonId;
                        var idWilayah = wilayahId == null
                            ? _memberDetailLoad.idWilayah
                            : wilayahId;

                        var idPekerjaan = pekerjaanId == null
                            ? _memberDetailLoad.idPekerjaan
                            : pekerjaanId;

                        var idPendidikan = pendidikanId == null
                            ? _memberDetailLoad.idPendidikan
                            : pendidikanId;

                        var idKeahlian = keahlianId == null
                            ? _memberDetailLoad.idKeahlian
                            : keahlianId;

                        var idKonsentrasi = konsentrasiId == null
                            ? _memberDetailLoad.idKonsentrasi
                            : konsentrasiId;
//
                        String memberId = await storage.read(key: 'memberId');
                        String token = await storage.read(key: 'token');
                        String url =
                            'https://maxproitsolution.com/apikompag/api/anggota/self-update-member/$memberId';
                        // String token = await storage.read(key: 'token');
                        Map<String, String> headers = {
                          "Content-Type": "application/json",
                          'Accept': 'application/json',
                          'Authorization': 'Bearer $token'
                        };

                        //  String json =
                        var response = await http.put(Uri.parse(url),
                            headers: headers,
                            body: jsonEncode({
                              'nama': nama,
                              'id_marga': idMarga,
                              'id_parampuon': idParompuon,
                              // 'id_sektor' : i,
                              'id_wilayah': idWilayah,
                              'id_generation': idGenerasi,
                              'jk': jk,
                              // 'kota',
                              'status': status,
                              'id_gelar': idGelar,
                              'id_title': idTitle,
                              'id_konsentrasi': idKonsentrasi,
                              'id_pekerjaan': idPekerjaan,
                              'id_pendidikan': idPendidikan,
                              'id_keahlian': idKeahlian,
                              'tgl_lahir': datatglLahir,
                              'tempat_lahir': tempatLahir,
                              'no_ktp': noKTP,
                              'no_kk': noKK,
                              'no_hp': noHp,
                              'email': email,
                            }));

                        // print(response.body);
                        if (response.statusCode == 200) {
                          storage.write(key: 'nama', value: nama);
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => BottomNavScreen(
                                    // nama: widget.nama,
                                    // noHp: noHpRegisterController.text),
                                    ),
                              ));
                        }
                        // print(
                        //     'nama : $nama,tempat lahir : $tempatLahir, tgl_lahir: $tglLahir, title: $titleId, gelar: $gelarId');
                      },
                      steps: [
                        CoolStep(
                          validation: () {
                            if (emailController.text == null) {
                              return "Fill form correctly";
                            }
                            return null;
                          },
                          title: "Data diri",
                          subtitle: "Harap isi lengkap data diri anda",
                          content: Container(
                            child: Center(
                                child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 6, left: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Nama lengkap :',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                MyTextField(
                                  withIcon: false,
                                  formKey: _formKey,
                                  controller: namaController,
                                  hintText: 'Nama',
                                  inputType: TextInputType.name,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 2, left: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Marga :',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.only(
                                    right: 8,
                                  ),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              onTap: () => {print('tap')},
                                              value: margaId,
                                              iconSize: 40,
                                              icon: (null),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                              hint: Text("$namaMarga"),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  // print(margaId);
                                                  margaId = newValue;
                                                  // _getCitiesList();
                                                  // getMarga();
                                                  // print(margaId);
                                                });
                                              },
                                              items: _marga?.map((item) {
                                                    return new DropdownMenuItem(
                                                      child: new Text(
                                                          item['nama']),
                                                      value:
                                                          item['id'].toString(),
                                                    );
                                                  })?.toList() ??
                                                  [],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 2, left: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Generasi :',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    right: 8,
                                  ),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              onTap: () => {print('tap')},
                                              value: generasiId,
                                              iconSize: 40,
                                              icon: (null),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                              hint: Text("$namaGenerasi"),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  // print(newValue);
                                                  generasiId = newValue;
                                                  // _getCitiesList();
                                                  // getMarga();
                                                  // print(margaId);
                                                });
                                              },
                                              items: _generasi?.map((item) {
                                                    return new DropdownMenuItem(
                                                      child: new Text(
                                                          item['nama']),
                                                      value:
                                                          item['id'].toString(),
                                                    );
                                                  })?.toList() ??
                                                  [],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 2, left: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Parompuon :',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    right: 8,
                                  ),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              onTap: () => {print('tap')},
                                              value: parompuonId,
                                              iconSize: 40,
                                              icon: (null),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                              hint: Text("$namaParompuon"),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  print(newValue);
                                                  parompuonId = newValue;
                                                  // _getCitiesList();
                                                  // getMarga();
                                                  // print(margaId);
                                                });
                                              },
                                              items: _parompuon?.map((item) {
                                                    return new DropdownMenuItem(
                                                      child: new Text(
                                                          item['nama']),
                                                      value:
                                                          item['id'].toString(),
                                                    );
                                                  })?.toList() ??
                                                  [],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 2, left: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Wilayah :',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    right: 8,
                                  ),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              onTap: () => {print('tap')},
                                              value: wilayahId,
                                              iconSize: 40,
                                              icon: (null),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                              hint: Text("$namaWilayah"),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  // print(newValue);
                                                  wilayahId = newValue;
                                                  // _getCitiesList();
                                                  // getMarga();
                                                  // print(margaId);
                                                });
                                              },
                                              items: _wilayah?.map((item) {
                                                    return new DropdownMenuItem(
                                                      child: new Text(
                                                          item['nama']),
                                                      value:
                                                          item['id'].toString(),
                                                    );
                                                  })?.toList() ??
                                                  [],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                // Container(
                                //   padding: EdgeInsets.only(
                                //     right: 8,
                                //   ),
                                //   color: Colors.white,
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: <Widget>[
                                //       Expanded(
                                //         child: DropdownButtonHideUnderline(
                                //           child: ButtonTheme(
                                //             alignedDropdown: true,
                                //             child: DropdownButton<String>(
                                //               onTap: () => {print('tap')},
                                //               value: margaId,
                                //               iconSize: 40,
                                //               icon: (null),
                                //               style: TextStyle(
                                //                 color: Colors.grey,
                                //                 fontSize: 14,
                                //               ),
                                //               hint: Text('Pilih sektor'),
                                //               onChanged: (String newValue) {
                                //                 setState(() {
                                //                   print(newValue);
                                //                   margaId = newValue;
                                //                   // _getCitiesList();
                                //                   // getMarga();
                                //                   // print(margaId);
                                //                 });
                                //               },
                                //               items: _sektor?.map((item) {
                                //                     return new DropdownMenuItem(
                                //                       child: new Text(item['nama']),
                                //                       value: item['id'].toString(),
                                //                     );
                                //                   })?.toList() ??
                                //                   [],
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            )),
                          ),
                        ),
                        CoolStep(
                          validation: () {
                            if (emailController.text == null) {
                              return "Fill form correctly";
                            }
                            return null;
                          },
                          title: "Data tambahan",
                          subtitle: "Harap isi lengkap data diri anda",
                          content: Container(
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  // MyTextField(
                                  //   controller: emailController,
                                  //   hintText: 'Nama lengkap',
                                  //   inputType: TextInputType.text,
                                  // ),
                                  // SizedBox(
                                  //   height: 2,
                                  // ),
                                  Container(
                                    padding: EdgeInsets.only(top: 6, left: 6),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Tempat lahir :',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),

                                  MyTextField(
                                     withIcon: false,
                                    formKey: _formKey1,
                                    controller: tempatLahirController,
                                    hintText: 'Tempat lahir',
                                    inputType: TextInputType.text,
                                  ),
                                  MyTextField(
                                     withIcon: false,
                                    formKey: _formKey2,
                                    enableInput: false,
                                    controller: tglLahirController,
                                    hintText: '$tglLahir',
                                    inputType: TextInputType.text,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: 14,
                                      left: 14,
                                    ),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              DatePicker.showDatePicker(context,
                                                  showTitleActions: true,
                                                  minTime: DateTime(1900, 1, 1),
                                                  maxTime: DateTime(2015, 1, 1),
                                                  onChanged: (date) {
                                                print('changess $date');
                                              }, onConfirm: (date) {
                                                //  final DateTime now = DateTime.now();
                                                final DateFormat formatter =
                                                    DateFormat('yyyy-MM-dd');
                                                final String formatted =
                                                    formatter.format(date);
                                                // print(formatted); // something like 2013-04-20
                                                // var dateTime =
                                                // DateTime.parse(
                                                // "$date");
                                                setState(() {
                                                  tglLahir = formatted;
                                                });
                                              },
                                                  currentTime: DateTime.now(),
                                                  locale: LocaleType.id);
                                            },
                                            child: Text(
                                              'Ubah Tanggal lahir',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 22, left: 6),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Title :',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: 8,
                                    ),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: DropdownButtonHideUnderline(
                                            child: ButtonTheme(
                                              alignedDropdown: true,
                                              child: DropdownButton<String>(
                                                onTap: () => {print('tap')},
                                                value: gelarDepanId,
                                                iconSize: 40,
                                                icon: (null),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                                hint: Text('$namaTitle'),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    // print(newValue);
                                                    gelarDepanId = newValue;
                                                    // _getCitiesList();
                                                    // getMarga();
                                                    // print(margaId);
                                                  });
                                                },
                                                items: _gelarDepan?.map((item) {
                                                      return new DropdownMenuItem(
                                                        child: new Text(
                                                            item['nama']),
                                                        value: item['id']
                                                            .toString(),
                                                      );
                                                    })?.toList() ??
                                                    [],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 6, left: 6),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Gelar :',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: 8,
                                    ),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: DropdownButtonHideUnderline(
                                            child: ButtonTheme(
                                              alignedDropdown: true,
                                              child: DropdownButton<String>(
                                                onTap: () => {print('tap')},
                                                value: titleId,
                                                iconSize: 40,
                                                icon: (null),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                                hint: Text('$namaGelar'),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    print(newValue);
                                                    titleId = newValue;
                                                    // _getCitiesList();
                                                    // getMarga();
                                                    // print(margaId);
                                                  });
                                                },
                                                items:
                                                    _gelarSarjana?.map((item) {
                                                          return new DropdownMenuItem(
                                                            child: new Text(
                                                                item['nama']),
                                                            value: item['id']
                                                                .toString(),
                                                          );
                                                        })?.toList() ??
                                                        [],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        CoolStep(
                          validation: () {
                            if (emailController.text == null) {
                              return "Fill form correctly";
                            }
                            return null;
                          },
                          title: "",
                          subtitle: "Harap isi lengkap data diri anda",
                          content: Container(
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 6, left: 18),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'No kartu Keluarga :',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: 14,
                                      left: 14,
                                    ),
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        MyTextField(
                                           withIcon: false,
                                          formKey: _formKey3,
                                          controller: noKkController,
                                          hintText: 'Nomer KK',
                                          inputType: TextInputType.number,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(top: 6, left: 6),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'No KTP :',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                        MyTextField(
                                           withIcon: false,
                                          formKey: _formKey4,
                                          controller: noKtpController,
                                          hintText: 'Nomer KTP',
                                          inputType: TextInputType.number,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(top: 6, left: 6),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Jenis kelamin :',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              CupertinoRadioChoice(
                                                selectedColor: Colors.red,
                                                choices: {
                                                  '1': 'Lelaki',
                                                  '2': 'Perempuan'
                                                },
                                                onChange: (selectedJk) {
                                                  // print(selectedJk);
                                                  setState(() {
                                                    jk = int.parse(selectedJk);
                                                  });
                                                },
                                                initialKeyValue: "$jk",
                                              ),
                                            ],
                                          ),
                                        ),
                                        // const Text(
                                        //   'Jenis kelamin',
                                        //   style: TextStyle(
                                        //       color: CupertinoColors.black,
                                        //       fontSize: 15.0),
                                        // ),
                                        // const Padding(
                                        //   padding: EdgeInsets.only(bottom: 5.0),
                                        // ),
                                        // CupertinoRadioChoice(
                                        //   choices: {'1': 'Lelaki', '2': 'Perempuan'},
                                        //   onChange: (selectedJk) {
                                        //     print(selectedJk);
                                        //   },
                                        //   initialKeyValue: '',
                                        // ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: 14,
                                      left: 14,
                                    ),
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        const Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 10.0),
                                        ),
                                        const Text(
                                          'Status :',
                                          style: TextStyle(
                                              color: CupertinoColors.black,
                                              fontSize: 15.0),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                        ),
                                        CupertinoRadioChoice(
                                          selectedColor: Colors.red,
                                          choices: {
                                            '4': 'Lajang',
                                            '5': 'Menikah',
                                            '6': 'Cerai'
                                          },
                                          onChange: (selectedStatus) {
                                            setState(() {
                                              status =
                                                  int.parse(selectedStatus);
                                            });
                                          },
                                          initialKeyValue: '$status',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        CoolStep(
                          validation: () {
                            if (emailController.text == null) {
                              return "Fill form correctly";
                            }
                            return null;
                          },
                          title: "Kontak",
                          subtitle: "Harap isi lengkap data diri anda",
                          content: Container(
                            child: Center(
                                child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 2, left: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'No HP :',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                MyTextField(
                                   withIcon: false,
                                    formKey: _formKey5,
                                    controller: noHpController,
                                    hintText: 'No HP',
                                    inputType: TextInputType.number),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 2, left: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Email :',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                MyTextField(
                                   withIcon: false,
                                  formKey: _formKey6,
                                  controller: emailController,
                                  hintText: 'Email',
                                  inputType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                              ],
                            )),
                          ),
                        ),
                        CoolStep(
                          validation: () {
                            if (emailController.text == null) {
                              return "Fill form correctly";
                            }
                            return null;
                          },
                          title: "Info lain",
                          subtitle: "Harap isi lengkap data diri anda",
                          content: Container(
                            child: Center(
                                child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 2, left: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Pekerjaan :',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    right: 8,
                                  ),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              onTap: () => {print('tap')},
                                              value: pekerjaanId,
                                              iconSize: 40,
                                              icon: (null),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                              hint: Text('$namaPekerjaan'),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  // print(newValue);
                                                  pekerjaanId = newValue;
                                                  // _getCitiesList();
                                                  // getMarga();
                                                  // print(margaId);
                                                });
                                              },
                                              items: _pekerjaan?.map((item) {
                                                    return new DropdownMenuItem(
                                                      child: new Text(
                                                          item['nama']),
                                                      value:
                                                          item['id'].toString(),
                                                    );
                                                  })?.toList() ??
                                                  [],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 2, left: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Pendidikan :',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    right: 8,
                                  ),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              onTap: () => {print('tap')},
                                              value: pendidikanId,
                                              iconSize: 40,
                                              icon: (null),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                              hint: Text('$namaPendidikan'),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  pendidikanId = newValue;
                                                  // _getCitiesList();
                                                  // getMarga();
                                                  // print(margaId);
                                                });
                                              },
                                              items: _pendidikan?.map((item) {
                                                    return new DropdownMenuItem(
                                                      child: new Text(
                                                          item['nama']),
                                                      value:
                                                          item['id'].toString(),
                                                    );
                                                  })?.toList() ??
                                                  [],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 2, left: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Keahlian :',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    right: 8,
                                  ),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              onTap: () => {print('tap')},
                                              value: keahlianId,
                                              iconSize: 40,
                                              icon: (null),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                              hint: Text('$namaKeahlian'),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  print(newValue);
                                                  keahlianId = newValue;
                                                  // _getCitiesList();
                                                  // getMarga();
                                                  // print(margaId);
                                                });
                                              },
                                              items: _keahlian?.map((item) {
                                                    return new DropdownMenuItem(
                                                      child: new Text(
                                                          item['nama']),
                                                      value:
                                                          item['id'].toString(),
                                                    );
                                                  })?.toList() ??
                                                  [],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 2, left: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Konsentrasi :',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    right: 8,
                                  ),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              onTap: () => {print('tap')},
                                              value: konsentrasiId,
                                              iconSize: 40,
                                              icon: (null),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                              hint: Text('$namaKonsentrasi'),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  print(newValue);
                                                  konsentrasiId = newValue;
                                                  // _getCitiesList();
                                                  // getMarga();
                                                  // print(margaId);
                                                });
                                              },
                                              items: _konsentrasi?.map((item) {
                                                    return new DropdownMenuItem(
                                                      child: new Text(
                                                          item['nama']),
                                                      value:
                                                          item['id'].toString(),
                                                    );
                                                  })?.toList() ??
                                                  [],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                // Container(
                                //   padding: EdgeInsets.only(
                                //     right: 8,
                                //   ),
                                //   color: Colors.white,
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: <Widget>[
                                //       Expanded(
                                //         child: DropdownButtonHideUnderline(
                                //           child: ButtonTheme(
                                //             alignedDropdown: true,
                                //             child: DropdownButton<String>(
                                //               onTap: () => {print('tap')},
                                //               value: margaId,
                                //               iconSize: 40,
                                //               icon: (null),
                                //               style: TextStyle(
                                //                 color: Colors.grey,
                                //                 fontSize: 14,
                                //               ),
                                //               hint: Text('Pilih sektor'),
                                //               onChanged: (String newValue) {
                                //                 setState(() {
                                //                   print(newValue);
                                //                   margaId = newValue;
                                //                   // _getCitiesList();
                                //                   // getMarga();
                                //                   // print(margaId);
                                //                 });
                                //               },
                                //               items: _sektor?.map((item) {
                                //                     return new DropdownMenuItem(
                                //                       child: new Text(item['nama']),
                                //                       value: item['id'].toString(),
                                //                     );
                                //                   })?.toList() ??
                                //                   [],
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            )),
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ));
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Palette.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(200.0),

              // bottomRight: Radius.circular(45.0)
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: <Widget>[
            //     Text(
            //       'Maxpos',
            //       style: const TextStyle(
            //           color: Colors.white,
            //           fontSize: 30.0,
            //           fontWeight: FontWeight.bold),
            //     )
            //   ],
            // ),
            SizedBox(
              height: screenHeight * 0.0005,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Profile',
                  // textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600),
                ),
                // Text('Update data',
                //     style: TextStyle(
                //         color: Colors.white70,
                //         fontSize: 15.0,
                //         fontWeight: FontWeight.w300)),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                // Row(
                //   children: <Widget>[
                //     FlatButton.icon(
                //         padding: const EdgeInsets.symmetric(
                //             vertical: 10.0, horizontal: 20.0),
                //         onPressed: () {
                //           print('featured list tapped');
                //         },
                //         icon: const Icon(Icons.featured_play_list,
                //             color: Colors.black),
                //         color: Colors.white,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(30.0)),
                //         label: Text('Featured List',
                //             style: Styles.buttonTextStyle),
                //         textColor: Colors.black)
                //   ],
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
