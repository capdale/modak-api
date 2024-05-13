import 'package:http/http.dart' as http;
import 'package:modak/modak.dart';
import 'package:modak/src/api/request.dart';
import 'package:test/test.dart';

final getCollectionsUUIDBody = """
{
    "collections": [
        "55a8f3c3-0d48-44af-87ad-bfb7e340a10e",
        "55178c2f-5d11-4c03-81dc-cb34176f6451"
    ]
}
""";

final getCollectionByUUIDBody = """
{
    "index": 1,
    "geolocation": {
        "longtitude": 1.12345,
        "latitude": 1.12345,
        "altitude": 1.12345,
        "acc": 0
    },
    "datetime": "2000-10-12T12:34:56.0123456+09:00"
}
""";

void main() {
  group("collection response unpacking test", () {
    test("get collections uuid unpacking test", () {
      final res = http.Response(getCollectionsUUIDBody, 200);
      final data = responseJsonWrapper(CollectionsUUID.fromJson)(res);
      expect(data, isA<CollectionsUUID>());
    });
    test("get collection unpacking test", () {
      final res = http.Response(getCollectionByUUIDBody, 200);
      final data = responseJsonWrapper(Collection.fromJson)(res);
      expect(data, isA<Collection>());
    });
  });
}
