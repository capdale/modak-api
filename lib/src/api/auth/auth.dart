import 'dart:convert';

import 'package:http/http.dart';
import 'package:modak/src/api/auth/auth_dto.dart';
import 'package:modak/src/api/endpoint.dart';
import 'package:modak/src/api/request.dart';
import 'package:modak/src/token.dart';

class TokenNotExpiredError implements Exception {
  TokenNotExpiredError();
}

class AuthFailedError implements Exception {
  AuthFailedError();
}

Map<String, String> addTokenHeader(Token token, {Map<String, String>? header}) {
  header ??= <String, String>{};
  header["Authorization"] = "Bearer ${token.tokenString}";
  return header;
}

class AuthAPI implements IAPIRequest {
  Token token;
  String _refreshToken;
  Endpoint endpoint;
  AuthAPI(this.token, this._refreshToken, this.endpoint);

  @override
  Future<T> get<T, G>(String url, T Function(G json) task,
      {Map<String, String>? headers}) async {
    try {
      return await APIRequest().getWithToken(url, task, token);
    } on AuthenticationError catch (e) {
      await refreshToken();
      return await APIRequest()
          .getWithToken(url, task, token, headers: headers);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshToken() async {
    if (!token.isExpired()) {
      throw Exception("token is not expired yet");
    }
    print("ASDFASDF");
    final refreshTokenRes = await post(
        "${endpoint.baseurl}/auth/refresh", RefreshTokenRes.fromJson,
        body: json.encode(<String, String>{"refresh_token": _refreshToken}));
    token = Token.parseFromString(refreshTokenRes.accessToken);
    _refreshToken = refreshTokenRes.refreshToken;
  }

  @override
  Future<T> post<T, G>(String url, T Function(G json) task,
      {Object? body, Map<String, String>? headers}) async {
    try {
      return await APIRequest()
          .postWithToken(url, task, token, body: body, headers: headers);
    } on AuthenticationError catch (e) {
      await refreshToken();
      return await APIRequest()
          .postWithToken(url, task, token, body: body, headers: headers);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<T> multipart<T, G>(
      String url, T Function(G json) task, List<MultipartFile> files,
      {Map<String, String>? headers}) async {
    try {
      return await APIRequest().multipart(url, task, files,
          headers: addTokenHeader(token, header: headers));
    } on AuthenticationError catch (e) {
      await refreshToken();
      return await APIRequest().multipart(url, task, files,
          headers: addTokenHeader(token, header: headers));
    } catch (e) {
      rethrow;
    }
  }
}
