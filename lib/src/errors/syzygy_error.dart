import 'syzygy_error_code.dart';
import 'syzygy_error_severity.dart';

/// Base error contract for all Syzygy errors. Implements [Exception] per
/// Dart convention so SyzygyError subtypes are catchable as both
/// `SyzygyError` and `Exception`.
abstract class SyzygyError implements Exception {
  SyzygyErrorCode get code;
  String get message;
  SyzygyErrorSeverity get severity;
  Object? get underlyingError;

  @override
  String toString() => 'SyzygyError(${code.rawValue}): $message';
}
