import 'dart:math';

/// Generic typed identifier wrapping a UUID-based String.
class SyzygyID<T> implements Comparable<SyzygyID<T>> {
  final String rawValue;

  const SyzygyID(this.rawValue);

  static final _random = Random();

  /// Generates a new random UUID-based SyzygyID.
  static SyzygyID<T> generate<T>() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex =
        bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    final uuid =
        '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
    return SyzygyID<T>(uuid);
  }

  @override
  bool operator ==(Object other) =>
      other is SyzygyID<T> && rawValue == other.rawValue;

  @override
  int get hashCode => rawValue.hashCode;

  @override
  int compareTo(SyzygyID<T> other) => rawValue.compareTo(other.rawValue);

  @override
  String toString() => rawValue;
}
