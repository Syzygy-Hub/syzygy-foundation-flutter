import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter_testing.dart';

void main() {
  group('MockLogger', () {
    late MockLogger logger;
    setUp(() => logger = MockLogger());

    test('records entries', () {
      logger.info('hello');
      expect(logger.entries, hasLength(1));
      expect(logger.entries.first.message, 'hello');
    });

    test('entriesForLevel filters correctly', () {
      logger.debug('d');
      logger.info('i');
      expect(logger.entriesForLevel(LogLevel.info), hasLength(1));
    });

    test('clear empties entries', () {
      logger.info('x');
      logger.clear();
      expect(logger.entries, isEmpty);
    });
  });
}
