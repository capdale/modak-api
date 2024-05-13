import 'dart:convert';
import 'package:mutex/mutex.dart';

import 'package:http/http.dart' as http;
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
  late final Mutex mutex;
  AuthAPI(this.token, this._refreshToken, this.endpoint) {
    mutex = Mutex();
  }

  @override
  Future<APIResponse<T>> get<T>(String url, T Function(http.Response res) task,
      {Map<String, String>? headers}) async {
    try {
      return await APIRequest().get(url, task, headers: addTokenHeader(token));
    } on AuthenticationError {
      await refreshToken();
      return await APIRequest().get(url, task, headers: addTokenHeader(token));
    } catch (e) {
      rethrow;
    }
  }

  /// refresh token, if refresh token not expired yet immediately return
  Future<void> refreshToken() async {
    await mutex.acquire();
    if (!token.isExpired()) {
      mutex.release();
      return;
    }
    try {
      final refreshTokenRes = await post("${endpoint.baseurl}/auth/refresh",
          responseJsonWrapper(RefreshTokenRes.fromJson),
          body: json.encode(<String, String>{"refresh_token": _refreshToken}));
      token = Token.parseFromString(refreshTokenRes.data.accessToken);
      _refreshToken = refreshTokenRes.data.refreshToken;
    } finally {
      mutex.release();
    }
  }

  @override
  Future<APIResponse<T>> post<T>(String url, T Function(http.Response res) task,
      {Object? body, Map<String, String>? headers}) async {
    try {
      return await APIRequest()
          .post(url, task, body: body, headers: addTokenHeader(token));
    } on AuthenticationError {
      await refreshToken();
      return await APIRequest()
          .post(url, task, body: body, headers: addTokenHeader(token));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<APIResponse<T>> multipart<T>(
      String url, T Function(http.Response res) task, List<MultipartFile> files,
      {Map<String, String>? headers}) async {
    try {
      return await APIRequest().multipart(url, task, files,
          headers: addTokenHeader(token, header: headers));
    } on AuthenticationError {
      await refreshToken();
      return await APIRequest().multipart(url, task, files,
          headers: addTokenHeader(token, header: headers));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<APIResponse<String>> delete(String url,
      {Object? body, Map<String, String>? headers}) async {
    try {
      return await APIRequest().delete(url,
          body: body, headers: addTokenHeader(token, header: headers));
    } on AuthenticationError {
      await refreshToken();
      return await APIRequest().delete(url, body: body, headers: headers);
    } catch (e) {
      rethrow;
    }
  }
}
