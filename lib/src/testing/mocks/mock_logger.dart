import '../../contracts/logging/log_entry.dart';
import '../../contracts/logging/log_level.dart';
import '../../contracts/logging/logger_protocol.dart';

/// Test double for [LoggerProtocol]. Captures all log entries in memory.
class MockLogger extends LoggerProtocol {
  final List<LogEntry> entries = [];

  @override
  void log(LogEntry entry) => entries.add(entry);

  List<LogEntry> entriesForLevel(LogLevel level) =>
      entries.where((e) => e.level == level).toList();

  void clear() => entries.clear();
}
