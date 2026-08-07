import '../../primitives/time/syzygy_timestamp.dart';
import 'log_entry.dart';
import 'log_level.dart';

/// Abstract logger contract with convenience methods.
abstract class LoggerProtocol {
  void log(LogEntry entry);

  void debug(String message, {Map<String, String> metadata = const {}}) {
    log(LogEntry(
      level: LogLevel.debug,
      message: message,
      timestamp: SyzygyTimestamp.now(),
      metadata: metadata,
    ));
  }

  void info(String message, {Map<String, String> metadata = const {}}) {
    log(LogEntry(
      level: LogLevel.info,
      message: message,
      timestamp: SyzygyTimestamp.now(),
      metadata: metadata,
    ));
  }

  void warning(String message, {Map<String, String> metadata = const {}}) {
    log(LogEntry(
      level: LogLevel.warning,
      message: message,
      timestamp: SyzygyTimestamp.now(),
      metadata: metadata,
    ));
  }

  void error(
    String message, {
    Object? error,
    Map<String, String> metadata = const {},
  }) {
    log(LogEntry(
      level: LogLevel.error,
      message: message,
      timestamp: SyzygyTimestamp.now(),
      metadata: metadata,
      error: error,
    ));
  }

  void critical(
    String message, {
    Object? error,
    Map<String, String> metadata = const {},
  }) {
    log(LogEntry(
      level: LogLevel.critical,
      message: message,
      timestamp: SyzygyTimestamp.now(),
      metadata: metadata,
      error: error,
    ));
  }
}
