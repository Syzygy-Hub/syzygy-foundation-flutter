import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter_testing.dart';

void main() {
  group('MockStorageProvider', () {
    late MockStorageProvider store;
    const key = StorageKey<String>('test-key');

    setUp(() => store = MockStorageProvider());

    test('set then get returns stored value', () {
      store.set('hello', key);
      expect(store.get(key), 'hello');
    });

    test('get returns null for missing key', () {
      expect(store.get(key), isNull);
    });

    test('remove deletes the value', () {
      store.set('hello', key);
      store.remove(key);
      expect(store.get(key), isNull);
    });

    test('clear empties all storage', () {
      store.set('a', const StorageKey<String>('key1'));
      store.set('b', const StorageKey<String>('key2'));
      store.clear();
      expect(store.storage, isEmpty);
    });

    test('stores multiple keys independently', () {
      store.set('valueA', const StorageKey<String>('keyA'));
      store.set('valueB', const StorageKey<String>('keyB'));
      expect(store.get(const StorageKey<String>('keyA')), 'valueA');
      expect(store.get(const StorageKey<String>('keyB')), 'valueB');
    });
  });
}
