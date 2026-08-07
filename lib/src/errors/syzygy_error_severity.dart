enum SyzygyErrorSeverity implements Comparable<SyzygyErrorSeverity> {
  info(0),
  warning(1),
  error(2),
  critical(3);

  final int level;
  const SyzygyErrorSeverity(this.level);

  @override
  int compareTo(SyzygyErrorSeverity other) => level.compareTo(other.level);
}
