import 'package:flutter_login_register_ui/main.dart';

Future<String> getStorageData(key) async {
  String data = await storage.read(key: key);
  // String memberId = await storage.read(key: 'memberId');
  // setState(() {
  //   _nama = data;
  //   _memberId = memberId;
  // });
  return data;
}
