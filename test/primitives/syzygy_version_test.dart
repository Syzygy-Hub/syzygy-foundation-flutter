import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter.dart';

void main() {
  group('SyzygyVersion', () {
    test('toString without prerelease', () {
      expect(const SyzygyVersion(1, 2, 3).toString(), '1.2.3');
    });

    test('toString with prerelease', () {
      expect(
        const SyzygyVersion(1, 0, 0, prerelease: 'beta').toString(),
        '1.0.0-beta',
      );
    });

    test('compareTo', () {
      const a = SyzygyVersion(1, 0, 0);
      const b = SyzygyVersion(2, 0, 0);
      expect(a.compareTo(b), isNegative);
    });

    test('current is 1.0.0', () {
      expect(SyzygyVersion.current, const SyzygyVersion(1, 0, 0));
    });

    test('current version string matches release', () {
      expect(SyzygyVersion.current.toString(), '1.0.0');
    });
  });
}
