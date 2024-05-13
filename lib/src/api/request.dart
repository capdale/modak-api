import 'dart:convert';

import 'package:http/http.dart' as http;

class APIResponse<T> {
  T data;
  int statusCode;
  APIResponse(this.data, this.statusCode);
}

abstract interface class IAPIRequest {
  Future<APIResponse<T>> get<T>(String url, T Function(http.Response res) task,
      {Map<String, String>? headers});
  Future<APIResponse<T>> post<T>(String url, T Function(http.Response res) task,
      {Object? body, Map<String, String>? headers});
  Future<APIResponse<T>> multipart<T>(String url,
      T Function(http.Response res) task, List<http.MultipartFile> files);
  Future<APIResponse<String>> delete(String url,
      {Object? body, Map<String, String>? headers});
}

class AuthenticationError implements Exception {
  final http.Response response;
  AuthenticationError(this.response);
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
  Future<APIResponse<T>> get<T>(String url, T Function(http.Response res) task,
      {Map<String, String>? headers}) async {
    final res = await http.get(Uri.parse(url), headers: headers);
    switch (res.statusCode) {
      case 200:
        return APIResponse(task(res), res.statusCode);
      case 401:
        throw AuthenticationError(res);
      default:
        throw RequestAPIError(res.statusCode, res.body);
    }
  }

  @override
  Future<APIResponse<T>> post<T>(String url, T Function(http.Response res) task,
      {Object? body, Map<String, String>? headers}) async {
    final res = await http.post(Uri.parse(url), headers: headers, body: body);
    switch (res.statusCode) {
      case 200:
        return APIResponse(task(res), res.statusCode);
      case 401:
        throw AuthenticationError(res);
      default:
        throw RequestAPIError(res.statusCode, res.body);
    }
  }

  @override
  Future<APIResponse<T>> multipart<T>(String url,
      T Function(http.Response res) task, List<http.MultipartFile> files,
      {Map<String, String>? headers}) async {
    final client = http.MultipartRequest('post', Uri.parse(url));
    if (headers != null) {
      client.headers.addAll(headers);
    }
    client.files.addAll(files);
    final streamResponse = await client.send();
    final res = await http.Response.fromStream(streamResponse);
    switch (streamResponse.statusCode) {
      case 200:
        return APIResponse(task(res), res.statusCode);
      case 401:
        throw AuthenticationError(res);
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
        throw AuthenticationError(res);
      default:
        throw RequestAPIError(res.statusCode, res.body);
    }
  }
}

T Function(http.Response response) responseJsonWrapper<T>(
    T Function(Map<String, dynamic> json) task) {
  return (http.Response response) => task(json.decode(response.body));
}
