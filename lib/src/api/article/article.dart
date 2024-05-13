import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:modak/src/api/article/article_dto.dart';
import 'package:modak/src/api/auth/auth.dart';
import 'package:modak/src/api/errors.dart';
import 'package:modak/src/api/request.dart';
import 'package:modak/src/api/endpoint.dart';

class ArticleAPI {
  AuthAPI auth;
  Endpoint endpoint;
  ArticleAPI(this.auth, this.endpoint);

  Future<Article> getArticle(String link) async {
    final article = await APIRequest().get("${endpoint.baseurl}/article/$link",
        responseJsonWrapper(Article.fromJson));
    return article.data;
  }

  ByteData _getByteData(http.Response res) {
    return ByteData.view(res.bodyBytes.buffer);
  }

  Future<ByteData> getArticleImage(String uuid) async {
    final res = await auth.get("${endpoint.baseurl}/image/$uuid", _getByteData);
    return res.data;
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
        "${endpoint.baseurl}/article", (res) => null, multipartFiles);
  }

  Future<ArticleLinks> getLinksByUserUUID(String user,
      {int offset = 0, int limit = 8}) async {
    if (offset < 0 || limit < 1 || limit > 64) {
      throw InvalidInputError(
          "offset: $offset, limit: $limit, expected value offset >= 0, 1 <= limit <= 64");
    }
    final links = await auth.get("${endpoint.baseurl}/article/get-links/$user",
        responseJsonWrapper(ArticleLinks.fromJson));
    return links.data;
  }

  Future<void> deleteArticleByLink(String link) async {
    await auth.delete("${endpoint.baseurl}/article/$link");
  }
}
