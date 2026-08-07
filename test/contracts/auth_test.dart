import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter.dart';

void main() {
  const token = AuthToken(accessToken: 'access-token');

  group('AuthToken.isExpired', () {
    test('is false when expiresAt is null', () {
      expect(const AuthToken(accessToken: 'tok').isExpired, isFalse);
    });

    test('is true when expiresAt is in the past', () {
      const past = SyzygyTimestamp(1); // 1ms after epoch — always past
      expect(const AuthToken(accessToken: 'tok', expiresAt: past).isExpired, isTrue);
    });

    test('is false when expiresAt is in the future', () {
      final future = SyzygyTimestamp(
        DateTime.now().millisecondsSinceEpoch + 3600000,
      );
      expect(AuthToken(accessToken: 'tok', expiresAt: future).isExpired, isFalse);
    });
  });

  group('AuthState', () {
    test('isAuthenticated is true only for Authenticated', () {
      expect(const Authenticated(token).isAuthenticated, isTrue);
      expect(const Unauthenticated().isAuthenticated, isFalse);
      expect(const AuthExpired(token).isAuthenticated, isFalse);
      expect(const Refreshing().isAuthenticated, isFalse);
    });

    test('token returns AuthToken for Authenticated', () {
      expect(const Authenticated(token).token, token);
    });

    test('token returns AuthToken for AuthExpired', () {
      expect(const AuthExpired(token).token, token);
    });

    test('token returns null for Unauthenticated', () {
      expect(const Unauthenticated().token, isNull);
    });

    test('token returns null for Refreshing', () {
      expect(const Refreshing().token, isNull);
    });
  });
}
