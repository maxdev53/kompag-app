import 'package:flutter_login_register_ui/main.dart';

Future<String> getToken() async {
  String token = await storage.read(key: 'token');
  return token;
}

// Future<String> getName() async {
//   String nama = await storage.read(key: 'nama');
//   return nama;
// }
