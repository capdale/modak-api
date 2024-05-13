import 'package:modak/modak.dart';
import 'package:modak/src/api/article/article_dto.dart';
import 'package:test/test.dart';

import 'setup.dart';

void main() {
  // must initialized when setUp
  late Modak m;
  late String collectionUUID;
  late String link;

  setUp(() {
    final config = loadTestConfig();
    m = config.getModak();
    collectionUUID = config.test.article.collectionUUID;
    link = config.test.article.link;
  });
  group('article', () {
    // fail test
    test('get article links', () async {
      doing() async => await m.article.getLinksByUserUUID("username");
      final expected = returnsNormally;

      expect(doing, expected);
    });

    test('post article', () async {
      final orders = [OrderInfo(collectionUUID, 0)];
      final imagePaths = ["./test/assets/test.jpg"];
      doing() async => await m.article
          .postArticle("new title", "new cotent", orders, imagePaths);
      final expected = returnsNormally;

      expect(doing, expected);
    });

    test('get article', () async {
      doing() async => await m.article.getArticle(link);
      final expected = returnsNormally;
      expect(doing, expected);
    });
  });
}
