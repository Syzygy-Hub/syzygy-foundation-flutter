/// Typed error code wrapping a string raw value.
class SyzygyErrorCode {
  final String rawValue;
  const SyzygyErrorCode(this.rawValue);

  @override
  bool operator ==(Object other) =>
      other is SyzygyErrorCode && rawValue == other.rawValue;

  @override
  int get hashCode => rawValue.hashCode;

  @override
  String toString() => rawValue;

  static const unknown = SyzygyErrorCode('unknown');
  static const cancelled = SyzygyErrorCode('cancelled');
  static const timeout = SyzygyErrorCode('timeout');
  static const unauthenticated = SyzygyErrorCode('unauthenticated');
  static const forbidden = SyzygyErrorCode('forbidden');
  static const notFound = SyzygyErrorCode('not_found');
  static const serverError = SyzygyErrorCode('server_error');
  static const networkUnavailable = SyzygyErrorCode('network_unavailable');
  static const decodingFailed = SyzygyErrorCode('decoding_failed');
  static const encodingFailed = SyzygyErrorCode('encoding_failed');
}
