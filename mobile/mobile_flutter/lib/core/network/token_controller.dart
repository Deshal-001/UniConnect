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
      }