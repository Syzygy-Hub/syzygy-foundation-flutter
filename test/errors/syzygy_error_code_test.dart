import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter.dart';

void main() {
  group('SyzygyErrorCode', () {
    test('static codes are defined', () {
      expect(SyzygyErrorCode.unknown, isNotNull);
      expect(SyzygyErrorCode.cancelled, isNotNull);
      expect(SyzygyErrorCode.timeout, isNotNull);
      expect(SyzygyErrorCode.unauthenticated, isNotNull);
      expect(SyzygyErrorCode.forbidden, isNotNull);
      expect(SyzygyErrorCode.notFound, isNotNull);
      expect(SyzygyErrorCode.serverError, isNotNull);
      expect(SyzygyErrorCode.networkUnavailable, isNotNull);
      expect(SyzygyErrorCode.decodingFailed, isNotNull);
      expect(SyzygyErrorCode.encodingFailed, isNotNull);
    });

    test('equality works for same rawValue', () {
      expect(
        const SyzygyErrorCode('timeout') == const SyzygyErrorCode('timeout'),
        isTrue,
      );
    });

    test('inequality for different rawValues', () {
      expect(
        const SyzygyErrorCode('timeout') == const SyzygyErrorCode('not_found'),
        isFalse,
      );
    });

    test('toString returns rawValue', () {
      expect(const SyzygyErrorCode('custom').toString(), 'custom');
    });
  });
}
