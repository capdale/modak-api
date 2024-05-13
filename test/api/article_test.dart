import 'package:http/http.dart' as http;
import 'package:modak/src/api/article/article_dto.dart';
import 'package:modak/src/api/request.dart';
import 'package:test/test.dart';

final getArticleBody = """
{
    "title": "title",
    "content": "content",
    "update_at": "2000-10-12T12:34:56.0123456+09:00",
    "collections": [
        {
            "uuid": "debcb53d-ca66-4f2c-bbbf-a64f84835f0a",
            "order": 0
        }
    ],
    "images": [
        {
            "uuid": "7cd3ca3b-58bf-409b-bd65-a8efbcac7cc1",
            "order": 0
        }
    ]
}
""";

final getLinksByUserUUIDBody = """
{
    "links": [
        "JAsXYx2_Q-mZeaW351aI4Q=="
    ]
}
""";

void main() {
  group("article response unpacking test", () {
    test("get article", () {
      final res = http.Response(getArticleBody, 200);
      final data = responseJsonWrapper(Article.fromJson)(res);
      expect(data, isA<Article>());
    });
    test("get links by user uuid response unpacking test", () {
      final res = http.Response(getLinksByUserUUIDBody, 200);
      final data = responseJsonWrapper(ArticleLinks.fromJson)(res);
      expect(data, isA<ArticleLinks>());
    });
  });
}
