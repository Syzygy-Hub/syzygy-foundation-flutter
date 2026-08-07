import '../../contracts/analytics/analytics_event.dart';
import '../../contracts/analytics/analytics_provider.dart';

/// Spy for [AnalyticsProvider]. Records all calls for assertion in tests.
class SpyAnalyticsProvider implements AnalyticsProvider {
  final List<AnalyticsEvent> trackedEvents = [];
  final List<({String userId, Map<String, Object?> traits})> identifiedUsers =
      [];
  int resetCallCount = 0;

  @override
  void track(AnalyticsEvent event) => trackedEvents.add(event);

  @override
  void identify(String userId, Map<String, Object?> traits) {
    identifiedUsers.add((userId: userId, traits: traits));
  }

  @override
  void reset() => resetCallCount++;

  List<AnalyticsEvent> eventsNamed(String name) =>
      trackedEvents.where((e) => e.name == name).toList();
}
