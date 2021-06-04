import 'dart:convert';

import 'package:flutter_login_register_ui/models/comment.dart';
import 'package:flutter_login_register_ui/models/informasi.dart';
import 'package:flutter_login_register_ui/models/latest_status.dart';
import 'package:flutter_login_register_ui/models/member_detail.dart';
import 'package:flutter_login_register_ui/models/response/post_comment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'marga.dart';
import 'member.dart';

class Services {
  static String uri = "https://maxproitsolution.com/apikompag/api";
  // static const String url =
  //     'https://maxproitsolution.com/apikompag/api/checkMember';

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
        Uri.parse('$uri/auth/logout'),
        headers: headers,
      );
      // print(response.statusCode);
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
      String url = '$uri/anggota/self-update-status-member/$idMember';
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

  static Future<PostCommentResponse> postComment(
      int statusId, String textComment) async {
    String token = await storage.read(key: 'token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.post(
      Uri.parse("$uri/anggota/comment"),
      body: json.encode({
        'status_id': statusId,
        'comment': textComment,
      }),
      headers: headers,
      // encoding: encoding,
      // body: {'statud_id': statusId, 'comment': textComment},
    );

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var responseBody = json.encode(body['data']);
      final PostCommentResponse commentResponse =
          postCommentResponseFromJson(responseBody);
      return commentResponse;
    } else {
      return PostCommentResponse();
    }
  }

  static Future postLike(int statusId) async {
    String token = await storage.read(key: 'token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.post(
      Uri.parse(
          "https://maxproitsolution.com/apikompag/api/anggota/like/status"),
      body: json.encode({
        'status_id': statusId,
      }),
      headers: headers,
      // encoding: encoding,
      // body: {'statud_id': statusId, 'comment': textComment},
    );
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future deleteLike(int statusId) async {
    String token = await storage.read(key: 'token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.delete(
      Uri.parse("$uri/anggota/like/status/$statusId"),
      // body: json.encode({
      //   'status_id': statusId,
      // }),
      headers: headers,
      // encoding: encoding,
      // body: {'statud_id': statusId, 'comment': textComment},
    );
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Member>> getMembers(dynamic keyword) async {
    try {
      final response = await http
          .post(Uri.parse('$uri/checkMember'), body: {'nama_member': keyword});
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
      final response = await http.get(Uri.parse('$uri/statistik/select-marga'));
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
      final response = await http.get(Uri.parse('$uri/informasi-terbaru'));

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        var responseBody = json.encode(body['data']);

        final List<Informasi> informasi = informasiFromJson(responseBody);
        return informasi;
      } else {}
    } catch (e) {}
  }

  static Future<List<Comment>> getComment(int statusId) async {
    try {
      String token = await storage.read(key: 'token');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await http
          .get(Uri.parse('$uri/anggota/status/$statusId'), headers: headers);
      // print(statusId);
      // print(response.body);

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        var responseBody = json.encode(body['data']['comments']);

        final List<Comment> comment = commentFromJson(responseBody);
        return comment;
        // print(comment);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<LatestStatus>> getLatestStatus() async {
    try {
      String token = await storage.read(key: 'token');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = await http.get(Uri.parse('$uri/anggota/latest/status'),
          headers: headers);

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        var responseBody = json.encode(body['data']);

        final List<LatestStatus> informasi = LatestStatusFromJson(responseBody);
        return informasi;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<Informasi>> getNewsInformation() async {
    try {
      final response = await http.get(Uri.parse('$uri/informasi-terbaru'));

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
      final response = await http.get(Uri.parse('$uri/informasi-voting'));

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
      final response = await http.get(Uri.parse('$uri/informasi-pengumuman'));

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
      final response = await http.get(Uri.parse('$uri/informasi-pengumuman'));

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
      // String url = ;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var response = await http.put(Uri.parse('$uri/auth/change-password'),
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
      final response = await http.get(Uri.parse('$uri/anggota/member/$memberId'));
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('detail_member', json.encode(response.body));

      final MemberDetail memberDetail = memberDetailFromJson(response.body);
      return response.body;
    } catch (e) {}
  }
}
