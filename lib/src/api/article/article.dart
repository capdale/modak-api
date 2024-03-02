import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:modak/src/api/article/article_dto.dart';
import 'package:modak/src/api/auth/auth.dart';
import 'package:modak/src/api/request.dart';
import 'package:modak/src/api/endpoint.dart';

class ArticleAPI {
  AuthAPI auth;
  Endpoint endpoint;
  ArticleAPI(this.auth, this.endpoint);

  Future<Article> getArticle(String link) async {
    final article = await APIRequest()
        .get("${endpoint.baseurl}/article/$link", Article.fromJson);
    return article;
  }

  Future<void> postArticle(String title, String content,
      List<OrderInfo> collectionOrderInfo, List<String> imagePaths) async {
    var multipartFiles = <http.MultipartFile>[];
    final postArticle = PostArticle(title, content, collectionOrderInfo);
    final jsonData = json.encode(postArticle.toJson());
    multipartFiles.add(http.MultipartFile.fromString('article', jsonData,
        contentType: MediaType('application', 'json')));

    for (var imagePath in imagePaths) {
      final imageFile = await http.MultipartFile.fromPath('image[]', imagePath);
      multipartFiles.add(imageFile);
    }
    await auth.multipart(
        "${endpoint.baseurl}/article", (json) => null, multipartFiles);
  }

  Future<ArticleLinks> getLinksByUserUUID(String userUUID) async {
    final links = await auth.get(
        "${endpoint.baseurl}/article/get-links/$userUUID",
        ArticleLinks.fromJson);
    return links;
  }
}
