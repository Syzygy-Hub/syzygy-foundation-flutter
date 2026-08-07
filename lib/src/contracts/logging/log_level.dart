enum LogLevel implements Comparable<LogLevel> {
  debug(0),
  info(1),
  warning(2),
  error(3),
  critical(4);

  final int severity;
  const LogLevel(this.severity);

  @override
  int compareTo(LogLevel other) => severity.compareTo(other.severity);
}
