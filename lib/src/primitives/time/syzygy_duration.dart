/// An immutable duration value based on milliseconds.
class SyzygyDuration implements Comparable<SyzygyDuration> {
  final int inMilliseconds;

  const SyzygyDuration._(this.inMilliseconds);

  static SyzygyDuration fromMilliseconds(int ms) => SyzygyDuration._(ms);
  static SyzygyDuration fromSeconds(double s) =>
      SyzygyDuration._((s * 1000).round());
  static SyzygyDuration fromMinutes(double m) =>
      SyzygyDuration._((m * 60000).round());
  static SyzygyDuration fromHours(double h) =>
      SyzygyDuration._((h * 3600000).round());

  double get totalSeconds => inMilliseconds / 1000.0;
  double get totalMinutes => inMilliseconds / 60000.0;
  double get totalHours => inMilliseconds / 3600000.0;

  @override
  bool operator ==(Object other) =>
      other is SyzygyDuration && inMilliseconds == other.inMilliseconds;

  @override
  int get hashCode => inMilliseconds.hashCode;

  @override
  int compareTo(SyzygyDuration other) =>
      inMilliseconds.compareTo(other.inMilliseconds);
}
