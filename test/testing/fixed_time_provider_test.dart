import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter_testing.dart';

void main() {
  group('FixedTimeProvider', () {
    test('now() returns the fixed time', () {
      const fixed = SyzygyTimestamp(5000);
      final provider = FixedTimeProvider(fixed);
      expect(provider.now(), equals(fixed));
    });

    test('since() computes duration from fixedTime', () {
      final provider = FixedTimeProvider(const SyzygyTimestamp(10000));
      const earlier = SyzygyTimestamp(3000);
      final duration = provider.since(earlier);
      expect(duration.inMilliseconds, 7000);
    });

    test('fixedTime can be mutated to advance time', () {
      final provider = FixedTimeProvider();
      provider.fixedTime = const SyzygyTimestamp(99000);
      expect(provider.now().millisecondsSinceEpoch, 99000);
    });

    test('default fixedTime is SyzygyTimestamp(0)', () {
      final provider = FixedTimeProvider();
      expect(provider.now().millisecondsSinceEpoch, 0);
    });
  });
}
