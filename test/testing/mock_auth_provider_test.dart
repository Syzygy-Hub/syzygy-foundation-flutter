import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter_testing.dart';

void main() {
  group('MockAuthProvider', () {
    late MockAuthProvider provider;
    const token = AuthToken(accessToken: 'access-token');

    setUp(() => provider = MockAuthProvider());
    tearDown(() => provider.dispose());

    test('initial state is Unauthenticated', () {
      expect(provider.state.isAuthenticated, isFalse);
    });

    test('authenticate transitions to Authenticated', () {
      provider.authenticate(token);
      expect(provider.state.isAuthenticated, isTrue);
    });

    test('token is accessible after authenticate', () {
      provider.authenticate(token);
      expect(provider.state.token, token);
    });

    test('signOut transitions to Unauthenticated and increments count', () {
      provider.authenticate(token);
      provider.signOut();
      expect(provider.state.isAuthenticated, isFalse);
      expect(provider.signOutCallCount, 1);
    });

    test('signOut increments count on each call', () {
      provider.signOut();
      provider.signOut();
      expect(provider.signOutCallCount, 2);
    });

    test('refresh increments refreshCallCount', () async {
      await provider.refresh();
      await provider.refresh();
      expect(provider.refreshCallCount, 2);
    });
  });
}
