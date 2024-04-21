import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modak/modak.dart';
import 'package:modak/src/api/auth/auth.dart';

class APIResponse<T> {
  T data;
  int statusCode;
  APIResponse(this.data, this.statusCode);
}

abstract interface class IAPIRequest {
  Future<APIResponse<T>> get<T, G>(String url, T Function(G json) task,
      {Map<String, String>? headers});
  Future<APIResponse<T>> post<T, G>(String url, T Function(G json) task,
      {Object? body, Map<String, String>? headers});
  Future<APIResponse<T>> multipart<T, G>(
      String url, T Function(G json) task, List<http.MultipartFile> files);
  Future<APIResponse<String>> delete(String url,
      {Object? body, Map<String, String>? headers});
}

class AuthenticationError implements Exception {
  final String message;
  AuthenticationError(this.message);
}

class RequestAPIError implements Exception {
  final int statusCode;
  final String body;
  RequestAPIError(this.statusCode, this.body);
}

class APIRequest implements IAPIRequest {
  APIRequest._init();
  static final APIRequest _instance = APIRequest._init();
  factory APIRequest() => _instance;

  @override
  Future<APIResponse<T>> get<T, G>(String url, T Function(G json) task,
      {Map<String, String>? headers}) async {
    final res = await http.get(Uri.parse(url), headers: headers);
    final j = json.decode(res.body);
    switch (res.statusCode) {
      case 200:
        return APIResponse(task(j), res.statusCode);
      case 401:
        throw AuthenticationError(j["message"]);
      default:
        throw RequestAPIError(res.statusCode, res.body);
    }
  }

  @override
  Future<APIResponse<T>> post<T, G>(String url, T Function(G json) task,
      {Object? body, Map<String, String>? headers}) async {
    final res = await http.post(Uri.parse(url), headers: headers, body: body);
    final j = json.decode(res.body);
    switch (res.statusCode) {
      case 200:
        return APIResponse(task(j), res.statusCode);
      case 401:
        throw AuthenticationError(j["message"]);
      default:
        throw RequestAPIError(res.statusCode, res.body);
    }
  }

  @override
  Future<APIResponse<T>> multipart<T, G>(
      String url, T Function(G json) task, List<http.MultipartFile> files,
      {Map<String, String>? headers}) async {
    final client = http.MultipartRequest('post', Uri.parse(url));
    if (headers != null) {
      client.headers.addAll(headers);
    }
    client.files.addAll(files);
    final streamResponse = await client.send();
    final res = await http.Response.fromStream(streamResponse);
    final j = json.decode(res.body);
    switch (streamResponse.statusCode) {
      case 200:
        return APIResponse(task(j), res.statusCode);
      case 401:
        throw AuthenticationError(j["message"]);
      default:
        throw RequestAPIError(res.statusCode, res.body);
    }
  }

  @override
  Future<APIResponse<String>> delete(String url,
      {Object? body, Map<String, String>? headers}) async {
    final res = await http.delete(Uri.parse(url), headers: headers, body: body);
    switch (res.statusCode) {
      case 200 || 204:
        return APIResponse(res.body, res.statusCode);
      case 401:
        throw AuthenticationError("");
      default:
        throw RequestAPIError(res.statusCode, res.body);
    }
  }
}
