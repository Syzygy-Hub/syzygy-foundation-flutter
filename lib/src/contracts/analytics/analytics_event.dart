import '../../primitives/time/syzygy_timestamp.dart';

/// A named analytics event with typed properties.
///
/// [properties] uses `Map<String, Object?>` for flexibility — values should
/// be primitives (String, num, bool, or null). Avoid deeply nested objects.
class AnalyticsEvent {
  final String name;

  /// Map<String, Object?> for flexibility. Values should be primitives
  /// (String, num, bool, or null).
  final Map<String, Object?> properties;
  final SyzygyTimestamp timestamp;

  AnalyticsEvent({
    required this.name,
    this.properties = const {},
    SyzygyTimestamp? timestamp,
  }) : timestamp = timestamp ?? SyzygyTimestamp.now();

  @override
  bool operator ==(Object other) =>
      other is AnalyticsEvent &&
      name == other.name &&
      timestamp == other.timestamp;

  @override
  int get hashCode => Object.hash(name, timestamp);
}
