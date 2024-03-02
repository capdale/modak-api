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

  group('collection test', () {
    test('get collection list test', () async {
      await m.collection.getCollectionsUUID(0, 100);
    });
    test('post collection test', () async {
      final collection = Collection(1, GeoLocation(1, 1, 1, 1), null);
      await m.collection.postCollection("./test/assets/test.jpg", collection);
    });
    test('get collection test', () async {
      await m.collection.getCollectionByUUID(testCollectionUUID);
    });
  });
}
