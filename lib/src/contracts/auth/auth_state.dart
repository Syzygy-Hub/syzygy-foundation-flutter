import 'auth_token.dart';

/// Sealed auth state for Stream-based auth observation.
sealed class AuthState {
  const AuthState();
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class Authenticated extends AuthState {
  final AuthToken token;
  const Authenticated(this.token);

  @override
  bool operator ==(Object other) =>
      other is Authenticated && token == other.token;

  @override
  int get hashCode => token.hashCode;
}

class AuthExpired extends AuthState {
  final AuthToken token;
  const AuthExpired(this.token);

  @override
  bool operator ==(Object other) =>
      other is AuthExpired && token == other.token;

  @override
  int get hashCode => token.hashCode;
}

class Refreshing extends AuthState {
  const Refreshing();
}

extension AuthStateX on AuthState {
  bool get isAuthenticated => this is Authenticated;

  AuthToken? get token => switch (this) {
        Authenticated(:final token) => token,
        AuthExpired(:final token) => token,
        _ => null,
      };
}
