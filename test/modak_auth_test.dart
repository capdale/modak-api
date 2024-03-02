import 'package:modak/modak.dart';
import 'package:modak/src/api/endpoint.dart';
import 'package:modak/src/token.dart';
import 'package:test/test.dart';

import 'setup.dart';

void main() {
  late String accessToken;
  late Endpoint endpoint;

  setUp(() {
    final config = loadTestConfig();

    accessToken = config.accessToken;
    endpoint = Endpoint(host: config.host, port: config.port);
  });

  group('token', () {
    test('valid token', () {
      doing() => Modak(
          token: Token.parseFromString(accessToken),
          refreshToken: "",
          endpoint: endpoint);

      final expected = returnsNormally;

      expect(doing, expected);
    });
  });

  group('invalid token', () {
    final expected = throwsA(isA<NoValidTokenError>()
        .having((p0) => p0.cause, 'invalid token', 'invalid token string'));
    void checkTokenInvalid(String invalidToken, Matcher matcher) {
      test("- $invalidToken", () {
        doing() => Modak(
            token: Token.parseFromString(invalidToken),
            refreshToken: "",
            endpoint: endpoint);
        expect(doing, matcher);
      });
    }

    // not in test so, setup is not included in this section so, load config again here
    final config = loadTestConfig();
    for (var token in config.test.auth.invalidTokens) {
      checkTokenInvalid(token, expected);
    }
  });

  group('invalid token (no uuid)', () {
    final expected = throwsA(isA<NoValidTokenError>()
        .having((p0) => p0.cause, 'invalid token', 'no uuid'));
    void checkNoUUIDToken(String noUUIDToken, Matcher matcher) {
      test("no uuid token $noUUIDToken", () {
        doing() => Modak(
            token: Token.parseFromString(noUUIDToken),
            refreshToken: "",
            endpoint: endpoint);
        expect(doing, matcher);
      });
    }

    final config = loadTestConfig();
    for (var token in config.test.auth.noUUIDTokens) {
      checkNoUUIDToken(token, expected);
    }
  });
}
