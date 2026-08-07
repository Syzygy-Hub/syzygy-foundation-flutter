import 'auth_token.dart';
import 'auth_state.dart';

/// Stream-based auth state contract for Flutter.
/// Implementations live in syzygy-services-flutter.
abstract class AuthProvider {
  Stream<AuthState> get stateStream;
  AuthState get state;
  void authenticate(AuthToken token);
  Future<AuthToken> refresh();
  void signOut();
}
