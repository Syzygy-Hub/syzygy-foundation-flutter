import 'dart:async';
import '../../contracts/auth/auth_provider.dart';
import '../../contracts/auth/auth_state.dart';
import '../../contracts/auth/auth_token.dart';
import '../fixtures/fixture_provider.dart';

/// Test double for [AuthProvider]. Supports configurable refresh behavior.
class MockAuthProvider implements AuthProvider {
  final _controller = StreamController<AuthState>.broadcast();
  AuthState _state = const Unauthenticated();
  int refreshCallCount = 0;
  int signOutCallCount = 0;
  Object? refreshError;
  AuthToken? refreshToken;

  MockAuthProvider() {
    refreshToken = Fixtures.authToken();
  }

  @override
  Stream<AuthState> get stateStream => _controller.stream;

  @override
  AuthState get state => _state;

  @override
  void authenticate(AuthToken token) {
    _state = Authenticated(token);
    _controller.add(_state);
  }

  @override
  Future<AuthToken> refresh() async {
    refreshCallCount++;
    if (refreshError != null) throw refreshError!;
    return refreshToken!;
  }

  @override
  void signOut() {
    signOutCallCount++;
    _state = const Unauthenticated();
    _controller.add(_state);
  }

  void dispose() => _controller.close();
}
