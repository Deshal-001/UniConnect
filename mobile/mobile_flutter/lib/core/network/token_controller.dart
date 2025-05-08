import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/token_constants.dart';

class TokenController {
  static Future<Map<String, String?>> readTokens() async {
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: TokenConstants.jwt);
    return {
      TokenConstants.jwt: jwt,
    };
  }

  static Future<void> storeTokens(Map<String, String?> tokens) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: TokenConstants.jwt, value: tokens[TokenConstants.jwt]);
    }

  static Future<void> deleteTokens() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: TokenConstants.jwt);
  }

  static Future<bool> isTokenExpired() async {
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: TokenConstants.jwt);
    if (jwt == null) {
      return true;
    }
    // Here you can add logic to check if the token is expired
    // For example, decode the JWT and check the expiration date
    return false;
  }

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: TokenConstants.jwt);
    return jwt;
  }
  static Future<void> clearAllTokens() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
  static Future<bool> hasToken() async {
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: TokenConstants.jwt);
    return jwt != null;
  }

}