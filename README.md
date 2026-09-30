[![Flutter](https://img.shields.io/badge/Flutter-Dart-7F77DD?style=flat)](https://flutter.dev/) [![Dart](https://img.shields.io/badge/Dart-3.0-1D9E75?logo=dart&logoColor=white&style=flat)](https://dart.dev) [![CI](https://img.shields.io/github/actions/workflow/status/Syzygy-Hub/syzygy-foundation-flutter/ci.yml?label=ci&style=flat)](https://github.com/Syzygy-Hub/syzygy-foundation-flutter/actions/workflows/ci.yml) [![Version](https://img.shields.io/badge/version-2.0.0-D85A30?style=flat)](https://github.com/Syzygy-Hub/syzygy-foundation-flutter/releases) [![License](https://img.shields.io/badge/License-MIT-green?style=flat)](LICENSE)

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/Syzygy-Hub/.github/main/brand/assets/banners/syzygy-banner-dark-1200.png">
  <img src="https://raw.githubusercontent.com/Syzygy-Hub/.github/main/brand/assets/banners/syzygy-banner-light-1200.png" alt="Syzygy" width="600">
</picture>

# syzygy-foundation-flutter

The root layer of the Syzygy ecosystem — providing SharedTypes, base protocols, and shared contracts that every peer layer builds on.

## About

syzygy-foundation-flutter is the base layer every other Syzygy Flutter library depends on. It defines the abstract classes that Services implements, the value types that UI and Core consume, and the error types the whole stack shares. Nothing in Foundation has behaviour beyond property storage — no network calls, no platform APIs, no business logic. Swap any implementation in Services or Core by extending these contracts; Foundation never needs to change.

## Role in the Syzygy Ecosystem

`syzygy-foundation-flutter` is the root layer — the only dependency shared by all peer layers. It depends on nothing. Every peer layer (UI, Core, Services, AI) depends on Foundation and nothing else.

Full ecosystem architecture: [ecosystem-fragment.md](https://github.com/Syzygy-Hub/.github/blob/main/docs/ecosystem-fragment.md)

### Shared Contracts

Foundation defines the shared contracts that all peer layers consume. These contracts are the abstraction layer that allows UI, Core, Services and AI to each depend on Foundation without depending on each other.

- **`NetworkClientProtocol`** — abstracts HTTP networking so any peer layer can make network requests without depending on a concrete implementation. `syzygy-services-flutter` provides the concrete Dio implementation.
- **`AuthProvider`** — abstracts authentication and token management. `syzygy-services-flutter` provides the concrete OAuth and flutter_secure_storage implementations.
- **`StorageProvider`** — abstracts local persistence. `syzygy-services-flutter` provides the concrete flutter_secure_storage implementation.
- **`LoggerProtocol`** — abstracts logging and observability so all peer layers can log without depending on a specific logging framework.

> These contracts are currently defined as planned interfaces. Concrete implementations will ship with `syzygy-services-flutter` in Phase 2 of the ecosystem roadmap.

## Release Process

Releases follow the Syzygy tag-push release flow:

1. Create a `release/X.X.X` branch
2. Bump the version in `syzygy.yml`, `pubspec.yaml`, the README badge, and `CHANGELOG.md`
3. Open a PR to `main` and wait for CI to pass
4. Merge the PR
5. Push the tag: `git tag X.X.X` and `git push origin X.X.X`
6. The tag push triggers the org-level release workflow which validates `syzygy.yml` matches the tag, extracts the CHANGELOG entry, publishes to pub.dev, and creates the GitHub Release

For the full release standard see the [Syzygy-Hub/.github release standard](https://github.com/Syzygy-Hub/.github/blob/main/engineering/standards/release-standard.md).

## Platforms

| Platform | Min Version | Package Manager | Status |
|---|---|---|---|
| Flutter | 3.10+ | pub.dev | ✅ Supported |

## Requirements

- Flutter 3.10+
- Dart 3.0+

## Installation

```yaml
dependencies:
  syzygy_foundation_flutter: ^2.0.0
```

```dart
// Runtime
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter.dart';

// Test support (test files only)
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter_testing.dart';
```

## Architecture

SyzygyFoundation exposes two libraries:

- **syzygy_foundation_flutter.dart** — runtime exports. Import in your app and library source files.
- **syzygy_foundation_flutter_testing.dart** — test support. Import in test files only.

**Depends on:** nothing

**Used by:** syzygy-ui-flutter, syzygy-core-flutter, syzygy-services-flutter, syzygy-ai-flutter

For the full ecosystem architecture see [syzygy-ecosystem.md](https://github.com/Syzygy-Hub/.github/blob/main/engineering/architecture/syzygy-ecosystem.md).

## API

### Primitives

- `SyzygyID<T>` — phantom-typed identifier preventing accidental ID mixing
- `SyzygyPage<T>` / `PaginationRequest` — paginated data structures
- `SyzygyTimestamp` / `SyzygyDuration` / `TimeProvider` — cross-platform time primitives
- `ValidationResult` / `ValidationRule` — validation contract and result type

### Contracts

#### `NetworkClientProtocol`
```dart
Future<NetworkResponse> execute(NetworkRequest request);
void dispose(); // v2.0.0 — cancels in-flight requests and releases resources
```

#### `StorageProvider` / `StorageKey`
Type-safe local persistence contract.

#### `AuthProvider`
```dart
Stream<AuthState> get stateStream;
AuthState get state;
void authenticate(AuthToken token);
Future<AuthToken> refresh();
void signOut();
bool canUseBiometric();                              // v2.0.0
Future<bool> authenticateWithBiometric(String reason); // v2.0.0
Future<bool> refreshToken();                         // v2.0.0
```

#### `ConnectivityProvider`
```dart
Stream<ConnectivityState> get stateStream;
ConnectivityState get state;
bool get isConnected;
void dispose(); // v2.0.0 — cancels subscriptions and releases resources
```

#### `AnalyticsProvider` / `AnalyticsEvent`
Analytics tracking contract.

#### `LoggerProtocol` / `LogLevel` / `LogEntry`
Structured logging contract.

### Shared Types

- `SyzygyEnvironment` — debug / staging / production
- `SyzygyConfiguration` — app configuration contract
- `SyzygyBuildInfo` — consumer-injected build metadata
- `SyzygyVersion` — semantic version with comparison support

### Errors

#### `SyzygyError` (existing)
- `SyzygyError` — base error abstract class
- `SyzygyErrorCode` — typed, extensible error codes
- `SyzygyErrorSeverity` — error severity levels

#### `SyzygyFoundationError` (v2.0.0)

A Dart `sealed class` hierarchy for Foundation-level errors. Use in exhaustive `switch` expressions:

```dart
switch (error) {
  case NetworkError(:final underlying):   // network-layer failure
  case AuthenticationError():              // authentication failure
  case NotFoundError():                    // resource not found
  case TimeoutError():                     // operation timed out
  case CancelledError():                   // operation cancelled
  case UnknownError(:final underlying):   // unclassified error
}
```

All subtypes implement `Exception`. `NetworkError`, `AuthenticationError`, and `UnknownError` accept an optional `underlying` `Object?` for wrapping the original exception.

### Testing Support

Import `syzygy_foundation_flutter_testing.dart` in test files only.

- `MockLogger`, `MockConnectivityProvider`, `MockAuthProvider`, `MockStorageProvider`, `MockNetworkClient`
- `SpyAnalyticsProvider`
- `FixtureProvider`, `FixedTimeProvider`

## Usage

### Implementing a contract

```dart
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter.dart';
import 'package:http/http.dart' as http;

class HttpNetworkClient extends NetworkClientProtocol {
  @override
  Future<NetworkResponse> execute(NetworkRequest request) async {
    final response = await http.get(Uri.parse(request.url));
    return NetworkResponse(
      statusCode: response.statusCode,
      data: response.bodyBytes,
      headers: response.headers,
    );
  }
}
```

### Using a primitive

```dart
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter.dart';

class User {}
class Post {}

void main() {
  final userId = SyzygyID<User>.generate();
  final postId = SyzygyID<Post>.generate();
  print(userId == postId); // false — distinct phantom types
}
```

### Using test support

```dart
import 'package:syzygy_foundation_flutter_testing/syzygy_foundation_flutter_testing.dart';
import 'package:test/test.dart';

void main() {
  test('execute returns queued response', () async {
    final client = MockNetworkClient();
    client.enqueue(NetworkResponse(statusCode: 200, data: Uint8List(0), headers: {}));
    final result = await client.execute(NetworkRequest(url: 'https://example.com'));
    expect(result.statusCode, equals(200));
  });
}
```

## Platform Notes

- Async pattern: `Future`
- `SyzygyError` is an abstract class implementing `Exception`
- `SyzygyFoundationError` is a Dart `sealed class` (not an enum) — use exhaustive `switch` for compile-time coverage
- `ConnectivityProvider`: controlled — pass `isOffline` prop (no first-party network detection)
- `SyzygyBuildInfo`: consumer-injected — populate at app startup
- Linting: `lints: ^5.0.0` (pure Dart, no Flutter SDK required). `flutter_lints` was removed in v2.0.0. `analysis_options.yaml` is fetched from `Syzygy-Hub/.github` at CI runtime and is gitignored locally.

## Breaking Changes (v2.0.0)

- **`NetworkClientProtocol.dispose()`** — abstract method added. All concrete implementations must implement `dispose()`.
- **`ConnectivityProvider.dispose()`** — abstract method added. All concrete implementations must implement `dispose()`.
- **`AuthProvider`** — three new abstract methods: `canUseBiometric()`, `authenticateWithBiometric(String reason)`, and `refreshToken()`. All concrete implementations must implement these.
- **`SyzygyFoundationError`** — new sealed error hierarchy. Callers should switch exhaustively on this type in error-handling code.
- **`flutter_lints` → `lints`** — if your project extended `package:flutter_lints/flutter.yaml`, update to `package:lints/recommended.yaml`.

## Contributing

Contributions are welcome. Please follow the [Syzygy engineering standards](https://github.com/Syzygy-Hub/.github/tree/main/engineering/standards) when submitting pull requests.

## License

MIT — see [LICENSE](LICENSE)
