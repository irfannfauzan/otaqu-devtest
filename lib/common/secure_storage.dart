import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Keystore {
  static final storage = FlutterSecureStorage();

  static Future save(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  static Future delete(String key) async {
    await storage.delete(key: key);
  }
}
