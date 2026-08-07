import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter_testing.dart';

void main() {
  group('SpyAnalyticsProvider', () {
    late SpyAnalyticsProvider spy;

    setUp(() => spy = SpyAnalyticsProvider());

    test('track records event', () {
      spy.track(AnalyticsEvent(name: 'button_tapped'));
      expect(spy.trackedEvents, hasLength(1));
      expect(spy.trackedEvents.first.name, 'button_tapped');
    });

    test('eventsNamed filters by name', () {
      spy.track(AnalyticsEvent(name: 'page_view'));
      spy.track(AnalyticsEvent(name: 'button_tapped'));
      spy.track(AnalyticsEvent(name: 'page_view'));
      expect(spy.eventsNamed('page_view'), hasLength(2));
      expect(spy.eventsNamed('button_tapped'), hasLength(1));
    });

    test('identify records userId', () {
      spy.identify('user-123', {'plan': 'pro'});
      expect(spy.identifiedUsers, hasLength(1));
      expect(spy.identifiedUsers.first.userId, 'user-123');
    });

    test('identify records traits', () {
      spy.identify('user-123', {'plan': 'pro'});
      expect(spy.identifiedUsers.first.traits, {'plan': 'pro'});
    });

    test('reset increments resetCallCount', () {
      spy.reset();
      spy.reset();
      expect(spy.resetCallCount, 2);
    });

    test('tracked events accumulate in order', () {
      spy.track(AnalyticsEvent(name: 'first'));
      spy.track(AnalyticsEvent(name: 'second'));
      expect(spy.trackedEvents[0].name, 'first');
      expect(spy.trackedEvents[1].name, 'second');
    });
  });
}
