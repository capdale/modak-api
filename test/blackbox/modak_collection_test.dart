import 'package:modak/modak.dart';
import 'package:test/test.dart';

import 'setup.dart';

void main() {
  // must initialized when setUp
  late Modak m;
  late String testCollectionUUID;

  setUp(() {
    final config = loadTestConfig();
    m = config.getModak();
    testCollectionUUID = config.test.collection.collectionUUID;
  });

  group('collection', () {
    test('get collection list', () async {
      await m.collection.getCollectionsUUID("", 0, 100);
    });
    test('post collection', () async {
      final collection = Collection(1, GeoLocation(1, 1, 1, 1), null);
      await m.collection.postCollection("./test/assets/test.jpg", collection);

      final defaultCollection = Collection(0, GeoLocation(0, 0, 0, 0), null);
      await m.collection
          .postCollection("./test/assets/test.jpg", defaultCollection);
    });
    test('get collection', () async {
      await m.collection.getCollectionByUUID(testCollectionUUID);
    });
  });
}
