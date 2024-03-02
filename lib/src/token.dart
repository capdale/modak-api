import 'dart:convert';

Codec<String, String> stringToBase64 = utf8.fuse(base64);

class NoValidTokenError implements Exception {
  String cause;
  NoValidTokenError(this.cause);
}

class Token {
  /// Modak token VO
  /// Generate new token from string with [Token.parseFromString]

  final String uuid;
  final DateTime exp;
  final String _tokenString;
  String get tokenString => _tokenString;

  Token(this.uuid, this.exp, this._tokenString);

  /// parseToken from string
  ///
  /// Throws a [NoValidTokenError] if string is not valid token
  static Token parseFromString(String tokenString) {
    final splitString = tokenString.split(".");
    if (splitString.length != 2) {
      throw NoValidTokenError("invalid token string");
    }
    String tokenBody = splitString[0];
    if (tokenBody.length % 4 != 0) {
      tokenBody += "=" * (4 - tokenBody.length % 4);
    }
    final decodedBody = stringToBase64.decode(tokenBody);
    Map<String, dynamic> jsonBody = jsonDecode(decodedBody);

    if (!jsonBody.containsKey("user")) throw NoValidTokenError("no uuid");
    final String uuid = jsonBody["user"];
    final exp = DateTime.fromMillisecondsSinceEpoch(jsonBody["exp"] * 1000);

    return Token(uuid, exp, tokenString);
  }

  bool isExpired() {
    final curTime = DateTime.now();
    if (curTime.compareTo(exp) < 0) {
      return false;
    }
    return true;
  }
}
