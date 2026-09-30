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
  AuthToken? refreshResult;
  bool _canUseBiometric = false;
  bool _biometricResult = false;
  bool _refreshTokenResult = false;

  MockAuthProvider() {
    refreshResult = Fixtures.authToken();
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
    return refreshResult!;
  }

  @override
  void signOut() {
    signOutCallCount++;
    _state = const Unauthenticated();
    _controller.add(_state);
  }

  @override
  bool canUseBiometric() => _canUseBiometric;

  void setBiometricAvailable({required bool value}) => _canUseBiometric = value;

  @override
  Future<bool> authenticateWithBiometric(String reason) async => _biometricResult;

  void setBiometricResult({required bool value}) => _biometricResult = value;

  @override
  Future<bool> refreshToken() async => _refreshTokenResult;

  void setRefreshTokenResult(bool value) => _refreshTokenResult = value;

  void dispose() => _controller.close();
}
