/// A typed key for use with [StorageProvider].
class StorageKey<T> {
  final String identifier;
  final T? defaultValue;

  const StorageKey(this.identifier, {this.defaultValue});

  @override
  bool operator ==(Object other) =>
      other is StorageKey<T> && identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;
}
