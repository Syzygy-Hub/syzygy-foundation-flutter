import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter.dart';

void main() {
  group('SyzygyEnvironment', () {
    test('isDebug is true only for debug', () {
      expect(SyzygyEnvironment.debug.isDebug, isTrue);
      expect(SyzygyEnvironment.staging.isDebug, isFalse);
      expect(SyzygyEnvironment.production.isDebug, isFalse);
    });

    test('isProduction is true only for production', () {
      expect(SyzygyEnvironment.production.isProduction, isTrue);
      expect(SyzygyEnvironment.debug.isProduction, isFalse);
      expect(SyzygyEnvironment.staging.isProduction, isFalse);
    });

    test('toString returns the enum name', () {
      expect(SyzygyEnvironment.debug.toString(), 'debug');
      expect(SyzygyEnvironment.staging.toString(), 'staging');
      expect(SyzygyEnvironment.production.toString(), 'production');
    });
  });
}
