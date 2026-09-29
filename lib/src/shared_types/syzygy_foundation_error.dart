/// Sealed error hierarchy for Syzygy Foundation.
///
/// All errors produced by Foundation-layer contracts extend [SyzygyFoundationError].
/// Callers can exhaustively switch on this type to handle every case.
sealed class SyzygyFoundationError implements Exception {
  const SyzygyFoundationError();
}

/// A network-layer failure. [underlying] holds the original exception, if any.
class NetworkError extends SyzygyFoundationError {
  final Object? underlying;
  const NetworkError({this.underlying});
}

/// An authentication failure (invalid credentials, expired token, etc.).
/// [underlying] holds the original exception, if any.
class AuthenticationError extends SyzygyFoundationError {
  final Object? underlying;
  const AuthenticationError({this.underlying});
}

/// The requested resource could not be found (HTTP 404 equivalent).
class NotFoundError extends SyzygyFoundationError {
  const NotFoundError();
}

/// An operation exceeded its time limit.
class TimeoutError extends SyzygyFoundationError {
  const TimeoutError();
}

/// An operation was cancelled before it could complete.
class CancelledError extends SyzygyFoundationError {
  const CancelledError();
}

/// A catch-all for errors that do not fit a more specific subtype.
/// [underlying] holds the original exception, if any.
class UnknownError extends SyzygyFoundationError {
  final Object? underlying;
  const UnknownError({this.underlying});
}
