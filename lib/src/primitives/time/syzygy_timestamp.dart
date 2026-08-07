/// An immutable point-in-time value based on milliseconds since epoch.
class SyzygyTimestamp implements Comparable<SyzygyTimestamp> {
  final int millisecondsSinceEpoch;

  const SyzygyTimestamp(this.millisecondsSinceEpoch);

  /// Returns the current time as a SyzygyTimestamp.
  static SyzygyTimestamp now() =>
      SyzygyTimestamp(DateTime.now().millisecondsSinceEpoch);

  double get secondsSinceEpoch => millisecondsSinceEpoch / 1000.0;

  DateTime toDateTime() =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

  bool operator <(SyzygyTimestamp other) =>
      millisecondsSinceEpoch < other.millisecondsSinceEpoch;

  bool operator >(SyzygyTimestamp other) =>
      millisecondsSinceEpoch > other.millisecondsSinceEpoch;

  @override
  bool operator ==(Object other) =>
      other is SyzygyTimestamp &&
      millisecondsSinceEpoch == other.millisecondsSinceEpoch;

  @override
  int get hashCode => millisecondsSinceEpoch.hashCode;

  @override
  int compareTo(SyzygyTimestamp other) =>
      millisecondsSinceEpoch.compareTo(other.millisecondsSinceEpoch);
}
