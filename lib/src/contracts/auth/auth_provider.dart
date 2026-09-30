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

  /// Returns true if biometric authentication is available and enrolled on this device.
  bool canUseBiometric();

  /// Triggers the system biometric prompt with [reason]. Returns true on success, false on failure or cancellation.
  Future<bool> authenticateWithBiometric(String reason);

  /// Silently refreshes the current session token. Returns true on success, false if refresh is unavailable or fails.
  Future<bool> refreshToken();
}
