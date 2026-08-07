import 'storage_key.dart';

/// Abstract key-value storage contract.
abstract class StorageProvider {
  T? get<T>(StorageKey<T> key);
  void set<T>(T value, StorageKey<T> key);
  void remove<T>(StorageKey<T> key);
  void clear();
}
