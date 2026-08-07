import '../../primitives/time/syzygy_timestamp.dart';

/// Represents an authentication token pair with optional expiry.
class AuthToken {
  final String accessToken;
  final String? refreshToken;
  final SyzygyTimestamp? expiresAt;

  const AuthToken({
    required this.accessToken,
    this.refreshToken,
    this.expiresAt,
  });

  bool get isExpired {
    if (expiresAt == null) return false;
    return expiresAt! < SyzygyTimestamp.now();
  }

  @override
  bool operator ==(Object other) =>
      other is AuthToken &&
      accessToken == other.accessToken &&
      refreshToken == other.refreshToken &&
      expiresAt == other.expiresAt;

  @override
  int get hashCode => Object.hash(accessToken, refreshToken, expiresAt);
}
