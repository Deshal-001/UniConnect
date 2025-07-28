import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../feature/authentication/domain/entities/user_class.dart';
import '../constants/token_constants.dart';

class TokenController {
  static const storage = FlutterSecureStorage();

  static Future<Map<String, String?>> readTokens() async {
    final jwt = await storage.read(key: TokenConstants.jwt);
    return {
      TokenConstants.jwt: jwt,
    };
  }

  static Future<void> storeTokens(Map<String, String?> tokens) async {
    await storage.write(key: TokenConstants.jwt, value: tokens[TokenConstants.jwt]);
  }

  static Future<void> deleteTokens() async {
    await storage.delete(key: TokenConstants.jwt);
  }

  static Future<bool> isTokenExpired() async {
    final jwt = await storage.read(key: TokenConstants.jwt);
    if (jwt == null) {
      return true;
    }
    // Here you can add logic to check if the token is expired
    // For example, decode the JWT and check the expiration date
    return false;
  }

  static Future<String?> getToken() async {
    final jwt = await storage.read(key: TokenConstants.jwt);
    return jwt;
  }

  static Future<void> clearAllTokens() async {
    await storage.deleteAll();
  }

  static Future<bool> hasToken() async {
    final jwt = await storage.read(key: TokenConstants.jwt);
    return jwt != null;
  }

  static Future<void> saveUser(User user) async {
    await storage.write(key: TokenConstants.userId, value: user.id.toString());
    await storage.write(key: TokenConstants.userName, value: user.fullName);
    await storage.write(key: TokenConstants.userEmail, value: user.email);
    await storage.write(key: TokenConstants.userImgUrl, value: user.imgUrl);
  }

  static Future<Map<String, String?>> getUserDetails() async {
    final userId = await storage.read(key: TokenConstants.userId);
    final userName = await storage.read(key: TokenConstants.userName);
    final userEmail = await storage.read(key: TokenConstants.userEmail);
    final userImgUrl = await storage.read(key: TokenConstants.userImgUrl);
    return {
      TokenConstants.userId: userId,
      TokenConstants.userName: userName,
      TokenConstants.userEmail: userEmail,
      TokenConstants.userImgUrl: userImgUrl,
    };
  }

  static Future<void> deleteUserDetails() async {
    await storage.delete(key: TokenConstants.userId);
    await storage.delete(key: TokenConstants.userName);
    await storage.delete(key: TokenConstants.userEmail);
    await storage.delete(key: TokenConstants.userImgUrl);
  }
}