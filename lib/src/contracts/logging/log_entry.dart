import '../../primitives/time/syzygy_timestamp.dart';
import 'log_level.dart';

/// A single log entry.
///
/// [metadata] uses `Map<String, String>` for type-safe structured context.
/// [error] is excluded from equality intentionally — two entries with the same
/// level/message/timestamp/metadata are considered equal regardless of the
/// attached error object.
class LogEntry {
  final LogLevel level;
  final String message;
  final SyzygyTimestamp timestamp;

  /// Type-safe string metadata for structured logging context.
  final Map<String, String> metadata;

  /// Excluded from equality — see class doc.
  final Object? error;

  const LogEntry({
    required this.level,
    required this.message,
    required this.timestamp,
    this.metadata = const {},
    this.error,
  });

  @override
  bool operator ==(Object other) =>
      other is LogEntry &&
      level == other.level &&
      message == other.message &&
      timestamp == other.timestamp &&
      metadata == other.metadata;

  @override
  int get hashCode => Object.hash(level, message, timestamp, metadata);
}
