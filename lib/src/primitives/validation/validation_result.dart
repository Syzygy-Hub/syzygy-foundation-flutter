/// Sealed result type for validation operations.
sealed class ValidationResult {
  const ValidationResult();
}

/// Represents a successful validation.
class Valid extends ValidationResult {
  const Valid();
}

/// Represents a failed validation with one or more error messages.
class Invalid extends ValidationResult {
  final List<String> messages;
  const Invalid(this.messages);
}

extension ValidationResultX on ValidationResult {
  bool get isValid => this is Valid;
  List<String> get messages => switch (this) {
        Valid() => const [],
        Invalid(:final messages) => messages,
      };
}
