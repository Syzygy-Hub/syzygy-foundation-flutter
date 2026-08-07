import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter.dart';

void main() {
  group('SyzygyID', () {
    test('generate() produces unique IDs', () {
      final a = SyzygyID.generate<String>();
      final b = SyzygyID.generate<String>();
      expect(a, isNot(equals(b)));
    });

    test('rawValue round-trip', () {
      const id = SyzygyID<int>('abc-123');
      expect(id.rawValue, 'abc-123');
      expect(id.toString(), 'abc-123');
    });

    test('equality', () {
      const a = SyzygyID<String>('same');
      const b = SyzygyID<String>('same');
      expect(a, equals(b));
    });

    test('compareTo', () {
      const a = SyzygyID<String>('aaa');
      const b = SyzygyID<String>('bbb');
      expect(a.compareTo(b), isNegative);
    });
  });
}
