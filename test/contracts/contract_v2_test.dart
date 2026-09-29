import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter_testing.dart';

void main() {
  group('MockNetworkClient v2.0.0', () {
    test('dispose() can be called without error', () {
      final client = MockNetworkClient();
      expect(() => client.dispose(), returnsNormally);
    });
  });

  group('MockConnectivityProvider v2.0.0', () {
    test('dispose() can be called without error', () {
      final provider = MockConnectivityProvider();
      expect(() => provider.dispose(), returnsNormally);
    });
  });

  group('MockAuthProvider v2.0.0', () {
    late MockAuthProvider auth;

    setUp(() => auth = MockAuthProvider());

    test('canUseBiometric() returns bool', () {
      expect(auth.canUseBiometric(), isA<bool>());
    });

    test('authenticateWithBiometric returns bool (async)', () async {
      final result = await auth.authenticateWithBiometric('Test reason');
      expect(result, isA<bool>());
    });

    test('refreshToken() returns bool (async)', () async {
      final result = await auth.refreshToken();
      expect(result, isA<bool>());
    });

    test('setRefreshTokenResult controls refreshToken() return value', () async {
      auth.setRefreshTokenResult(true);
      expect(await auth.refreshToken(), isTrue);
      auth.setRefreshTokenResult(false);
      expect(await auth.refreshToken(), isFalse);
    });
  });

  group('SyzygyFoundationError v2.0.0', () {
    test('NetworkError is a SyzygyFoundationError', () {
      const e = NetworkError();
      expect(e, isA<SyzygyFoundationError>());
    });

    test('AuthenticationError is a SyzygyFoundationError', () {
      const e = AuthenticationError();
      expect(e, isA<SyzygyFoundationError>());
    });

    test('NotFoundError is a SyzygyFoundationError', () {
      const e = NotFoundError();
      expect(e, isA<SyzygyFoundationError>());
    });

    test('TimeoutError is a SyzygyFoundationError', () {
      const e = TimeoutError();
      expect(e, isA<SyzygyFoundationError>());
    });

    test('CancelledError is a SyzygyFoundationError', () {
      const e = CancelledError();
      expect(e, isA<SyzygyFoundationError>());
    });

    test('UnknownError is a SyzygyFoundationError', () {
      const e = UnknownError();
      expect(e, isA<SyzygyFoundationError>());
    });

    test('NetworkError carries optional underlying', () {
      final cause = Exception('connection refused');
      final e = NetworkError(underlying: cause);
      expect(e.underlying, same(cause));
    });

    test('SyzygyFoundationError implements Exception', () {
      const e = TimeoutError();
      expect(e, isA<Exception>());
    });
  });
}
