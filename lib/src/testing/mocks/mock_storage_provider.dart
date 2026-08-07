import '../../contracts/storage/storage_key.dart';
import '../../contracts/storage/storage_provider.dart';

/// Test double for [StorageProvider]. In-memory key-value store.
class MockStorageProvider implements StorageProvider {
  final Map<String, Object?> _storage = {};

  Map<String, Object?> get storage => Map.unmodifiable(_storage);

  @override
  T? get<T>(StorageKey<T> key) {
    final value = _storage[key.identifier];
    return value as T? ?? key.defaultValue;
  }

  @override
  void set<T>(T value, StorageKey<T> key) {
    _storage[key.identifier] = value;
  }

  @override
  void remove<T>(StorageKey<T> key) {
    _storage.remove(key.identifier);
  }

  @override
  void clear() => _storage.clear();
}
