import 'validation_result.dart';

/// Abstract validation rule that can be applied to a value of type [T].
abstract class ValidationRule<T> {
  const ValidationRule();
  ValidationResult validate(T value);
}
