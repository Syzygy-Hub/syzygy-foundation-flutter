import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter.dart';

void main() {
  group('SyzygyTimestamp', () {
    test('now() returns a value after year 2020', () {
      final ts = SyzygyTimestamp.now();
      expect(ts.millisecondsSinceEpoch, greaterThan(1577836800000));
    });

    test('secondsSinceEpoch is milliseconds / 1000', () {
      const ts = SyzygyTimestamp(5000);
      expect(ts.secondsSinceEpoch, 5.0);
    });

    test('toDateTime converts correctly', () {
      const ts = SyzygyTimestamp(1000000);
      expect(ts.toDateTime().millisecondsSinceEpoch, 1000000);
    });

    test('later timestamp is greater than earlier', () {
      const earlier = SyzygyTimestamp(1000);
      const later = SyzygyTimestamp(2000);
      expect(later > earlier, isTrue);
      expect(earlier > later, isFalse);
    });

    test('earlier timestamp is less than later', () {
      const earlier = SyzygyTimestamp(1000);
      const later = SyzygyTimestamp(2000);
      expect(earlier < later, isTrue);
    });

    test('equality works for same milliseconds', () {
      expect(const SyzygyTimestamp(1000), equals(const SyzygyTimestamp(1000)));
    });
  });

  group('SyzygyDuration', () {
    test('fromSeconds(1) is 1000 milliseconds', () {
      expect(SyzygyDuration.fromSeconds(1.0).inMilliseconds, 1000);
    });

    test('fromMinutes(1) is 60000 milliseconds', () {
      expect(SyzygyDuration.fromMinutes(1.0).inMilliseconds, 60000);
    });

    test('fromHours(1) is 3600000 milliseconds', () {
      expect(SyzygyDuration.fromHours(1.0).inMilliseconds, 3600000);
    });

    test('fromMilliseconds produces correct value', () {
      expect(SyzygyDuration.fromMilliseconds(500).inMilliseconds, 500);
    });

    test('totalSeconds derived from milliseconds', () {
      expect(SyzygyDuration.fromSeconds(2.0).totalSeconds, 2.0);
    });

    test('totalMinutes derived from milliseconds', () {
      expect(SyzygyDuration.fromMinutes(3.0).totalMinutes, 3.0);
    });
  });
}
