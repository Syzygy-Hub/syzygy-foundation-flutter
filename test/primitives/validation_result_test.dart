import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter.dart';

void main() {
  group('ValidationResult', () {
    test('Valid.isValid is true', () {
      expect(const Valid().isValid, isTrue);
    });

    test('Invalid.isValid is false', () {
      expect(const Invalid(['error']).isValid, isFalse);
    });

    test('Invalid.messages contains messages', () {
      expect(const Invalid(['a', 'b']).messages, ['a', 'b']);
    });

    test('Valid.messages is empty', () {
      expect(const Valid().messages, isEmpty);
    });
  });
}
