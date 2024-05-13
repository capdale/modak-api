import 'package:modak/modak.dart';
import 'package:modak/src/api/endpoint.dart';
import 'package:modak/src/token.dart';
import 'package:test/test.dart';

import 'setup.dart';

void main() {
  late String accessToken;

  setUp(() {
    final config = loadTestConfig();
    accessToken = config.accessToken;
  });

  group('token', () {
    test('valid token', () {
      doing() => Token.parseFromString(accessToken);
      final expected = returnsNormally;
      expect(doing, expected);
    });
  });

  group('invalid token', () {
    final expected = throwsA(isA<NoValidTokenError>()
        .having((p0) => p0.cause, 'invalid token', 'invalid token string'));
    void checkTokenInvalid(String invalidToken, Matcher matcher) {
      test("- $invalidToken", () {
        doing() => Token.parseFromString(invalidToken);
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
        doing() => Token.parseFromString(noUUIDToken);
        expect(doing, matcher);
      });
    }

    final config = loadTestConfig();
    for (var token in config.test.auth.noUUIDTokens) {
      checkNoUUIDToken(token, expected);
    }
  });

  group('expired token', () {
    void checkExpiredToken(String expiredToken) {
      test(expiredToken, () {
        final isExpired = Token.parseFromString(expiredToken).isExpired();
        expect(isExpired, true);
      });
    }

    final config = loadTestConfig();
    for (var token in config.test.auth.expiredTokens) {
      checkExpiredToken(token);
    }
  });

  group('not expired token', () {
    void checkNotExpiredToken(String notExpiredToken) {
      test(notExpiredToken, () {
        final isExpired = Token.parseFromString(notExpiredToken).isExpired();
        expect(isExpired, false);
      });
    }

    final config = loadTestConfig();
    for (var token in config.test.auth.notExpiredToken) {
      checkNotExpiredToken(token);
    }
  });
}
