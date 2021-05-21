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
  static const String uri = 'https://apikompag.maxproitsolution.com/api/';
  static const String url =
      'https://apikompag.maxproitsolution.com/api/checkMember';

  static Future logOut() async {
    String token = await storage.read(key: 'token');
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      //  String json =
      var response = await http.post(
        uri + 'auth/logout',
        headers: headers,
      );
      if (response.statusCode == 200) {
        // final Marga marga = margaFromJson(response.body);
        // return marga;
        return true;
      } else {
        return false;
        // return Marga();
      }
    } catch (e) {}
  }

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
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {}
  }

  static Future<List<Member>> getMembers(dynamic keyword) async {
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

  static Future<List<Informasi>> getLatestInformation() async {
    try {
      final response = await http
          .get('https://apikompag.maxproitsolution.com/api/informasi-terbaru');

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        var responseBody = json.encode(body['data']);

        final List<Informasi> informasi = informasiFromJson(responseBody);
        return informasi;
      } else {}
    } catch (e) {}
  }

  static Future<List<Informasi>> getNewsInformation() async {
    try {
      final response = await http
          .get('https://apikompag.maxproitsolution.com/api/informasi-terbaru');

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        var responseBody = json.encode(body['data']);

        final List<Informasi> informasi = informasiFromJson(responseBody);
        return informasi;
      } else {}
    } catch (e) {}
  }

  static Future<List<Informasi>> getVotingInformation() async {
    try {
      final response = await http
          .get('https://apikompag.maxproitsolution.com/api/informasi-voting');

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        var responseBody = json.encode(body['data']);

        final List<Informasi> informasi = informasiFromJson(responseBody);
        return informasi;
      } else {}
    } catch (e) {}
  }

  static Future<List<Informasi>> getAnnouncementInformation() async {
    try {
      final response = await http
          .get('https://apikompag.maxproitsolution.com/api/informasi-pengumuman');

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        var responseBody = json.encode(body['data']);

        final List<Informasi> informasi = informasiFromJson(responseBody);
        return informasi;
      } else {}
    } catch (e) {}
  }

  static Future<List<Informasi>> getInvitationInformation() async {
    try {
      final response = await http
          .get('https://apikompag.maxproitsolution.com/api/informasi-undangan');

      if (response.statusCode == 200) {
        // print(response.body);
        var body = json.decode(response.body);
        var responseBody = json.encode(body['data']);

        final List<Informasi> informasi = informasiFromJson(responseBody);
        return informasi;
      } else {}
    } catch (e) {}
  }

  static Future<dynamic> changePassword(oldPw, newPw, confirmPw) async {
    try {
      String token = await storage.read(key: 'token');
      String url =
          'https://apikompag.maxproitsolution.com/api/auth/change-password';
      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var response = await http.put(url,
          headers: headers,
          body: jsonEncode({
            'password_lama': oldPw,
            'password_baru': newPw,
            'password_confirm': confirmPw
          }));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return false;
      }
    } catch (e) {}
  }

  static Future<String> getMemberDetail(String memberId) async {
    try {
      final response = await http.get(
          'https://apikompag.maxproitsolution.com/api/anggota/member/$memberId');
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('detail_member', json.encode(response.body));

      final MemberDetail memberDetail = memberDetailFromJson(response.body);
      return response.body;
    } catch (e) {}
  }
}
