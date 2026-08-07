import 'analytics_event.dart';

/// Abstract analytics contract.
abstract class AnalyticsProvider {
  void track(AnalyticsEvent event);

  /// [traits] uses Map<String, Object?> for flexibility.
  void identify(String userId, Map<String, Object?> traits);
  void reset();
}
