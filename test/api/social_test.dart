import 'package:http/http.dart' as http;
import 'package:modak/src/api/request.dart';
import 'package:modak/src/api/social/social_dto.dart';
import 'package:test/test.dart';

final followersBody = """
{
  "followers": [
    "f015ba1c-fb7a-4fc0-8cc3-670047bd8563",
    "d4f2a808-ae7e-43f5-b140-cf9d83767346"
  ]
}""";

final followingsBody = '''
{
  "followings": [
    "f015ba1c-fb7a-4fc0-8cc3-670047bd8563",
    "d4f2a808-ae7e-43f5-b140-cf9d83767346"
  ]
}''';

final followRequestsBody = '''
{
  "requests": [
    "f015ba1c-fb7a-4fc0-8cc3-670047bd8563",
    "d4f2a808-ae7e-43f5-b140-cf9d83767346"
  ]
}''';

final relationBody = '''
{
  "is_following": true,
  "is_follower": true
}
''';

void main() {
  group("social response unpacking test", () {
    test("get follower", () {
      final res = http.Response(followersBody, 200);
      final data = responseJsonWrapper(Followers.fromJson)(res);
      expect(data, isA<Followers>());
    });

    test("get followings", () {
      final res = http.Response(followingsBody, 200);
      final data = responseJsonWrapper(Followings.fromJson)(res);
      expect(data, isA<Followings>());
    });

    test("get follow requests", () {
      final res = http.Response(followRequestsBody, 200);
      final data =
          responseJsonWrapper((json) => FollowRequests.fromJson(json))(res);
      expect(data, isA<FollowRequests>());
    });

    test("get relation", () {
      final res = http.Response(relationBody, 200);
      final data = responseJsonWrapper((json) => Relation.fromJson(json))(res);
      expect(data, isA<Relation>());
    });
  });
}
