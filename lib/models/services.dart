import 'dart:convert';

import 'package:flutter_login_register_ui/models/informasi.dart';
import 'package:flutter_login_register_ui/models/member_detail.dart';
import 'package:flutter_login_register_ui/services/shared_pref.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'marga.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'member.dart';
import 'login.dart';

class Services {
  final String uri = 'https://apikompag.maxproitsolution.com/api/';
  static const String url =
      'https://apikompag.maxproitsolution.com/api/checkMember';

  static Future updateStatusMember(
      String idMember, String marga, String pasangan, String city) async {
    try {
      String token = await storage.read(key: 'token');
      String url =
          'https://apikompag.maxproitsolution.com/api/anggota/self-update-status-member/' +
              idMember;
      // String token = await storage.read(key: 'token');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      //  String json =
      var response = await http.put(url,
          headers: headers,
          body: jsonEncode({
            'keterangan_marga': marga,
            'keterangan_pasangan': pasangan,
            'keterangan_city': city
          }));
      // print(response.body);
      if (response.statusCode == 200) {
        // final Marga marga = margaFromJson(response.body);
        // return marga;
        return true;
      } else {
        return false;
        // return Marga();
      }
    } catch (e) {
      // return Marga();
    }
  }

  static Future<List<Member>> getMembers(dynamic keyword) async {
    // String keyword;
    //
    // print(keyword);
    try {
      final response = await http.post(
          'https://apikompag.maxproitsolution.com/api/checkMember',
          body: {'nama_member': keyword});
      if (response.statusCode == 200) {
        final List<Member> members = membersFromJson(response.body);
        return members;
      } else {
        return List<Member>();
      }
    } catch (e) {
      return List<Member>();
    }
  }

  static Future<Marga> getMarga() async {
    try {
      final response = await http.get(
          'https://apikompag.maxproitsolution.com/api/statistik/select-marga');
      // body: {'nama_member': keyword});
      if (response.statusCode == 200) {
        final Marga marga = margaFromJson(response.body);
        return marga;
      } else {
        return Marga();
      }
    } catch (e) {
      return Marga();
    }
  }

  static Future<List<Informasi>> getInformasi() async {
    try {
      final response = await http
          .get('https://apikompag.maxproitsolution.com/api/informasi-terbaru');
      // body: {'nama_member': keyword});
      // print(response.body);

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        // print(body['data']);
        var responseBody = json.encode(body['data']);

        final List<Informasi> informasi = informasiFromJson(responseBody);
        // print(informasi);
        return informasi;
      } else {
        // return Informasi();
      }
    } catch (e) {
      // return Informasi();
    }
  }

  // Static Future<Informasi> getInformasi() async {
  //   var res = await http.get('$uri/informasi-terbaru');

  //   if (res.statusCode == 200) {
  //     final Informasi informasi = informasiFromJson(res.body);
  //     return informasi;
  //   } else {
  //     throw ("gangguan");
  //   }
  // }

  static Future<dynamic> changePassword(oldPw, newPw, confirmPw) async {
    try {
      String token = await storage.read(key: 'token');
      String url =
          'https://apikompag.maxproitsolution.com/api/auth/change-password';
      // String token = await storage.read(key: 'token');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      //  String json =
      var response = await http.put(url,
          headers: headers,
          body: jsonEncode({
            'password_lama': oldPw,
            'password_baru': newPw,
            'password_confirm': confirmPw
          }));
      if (response.statusCode == 200) {
        // final Marga marga = margaFromJson(response.body);
        // return marga;
        return response.body;
      } else {
        return false;
        // return Marga();
      }
    } catch (e) {
      // return Marga();
    }
  }

  static Future<String> getMemberDetail(String memberId) async {
    // print(memberId);
    try {
      final response = await http.get(
          'https://apikompag.maxproitsolution.com/api/anggota/member/$memberId');
      // body: {'nama_member': keyword});
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('detail_member', json.encode(response.body));

      // print(memberId);
      // SharedPref sharedPref = SharedPref();

      // storage.write(key: 'memberDetail', value: response.body);
      // print(response.statusCode);
      // if (response.statusCode == 200) {
      // sharedPref.save('memberDetail', response.body);

      final MemberDetail memberDetail = memberDetailFromJson(response.body);
      // print("oke");
      return response.body;
      // }
    } catch (e) {
      // return MemberDetail();
    }
  }
}
