[![Flutter](https://img.shields.io/badge/Flutter-Dart-7F77DD?style=flat)](https://flutter.dev/) [![Dart](https://img.shields.io/badge/Dart-3.0-1D9E75?logo=dart&logoColor=white&style=flat)](https://dart.dev) [![CI](https://img.shields.io/github/actions/workflow/status/Syzygy-Hub/syzygy-foundation-flutter/ci.yml?label=ci&style=flat)](https://github.com/Syzygy-Hub/syzygy-foundation-flutter/actions/workflows/ci.yml) [![Version](https://img.shields.io/badge/version-1.2.0-D85A30?style=flat)](https://github.com/Syzygy-Hub/syzygy-foundation-flutter/releases) [![License](https://img.shields.io/badge/License-MIT-green?style=flat)](LICENSE)

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
  syzygy_foundation_flutter: ^1.2.0
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

- `NetworkClientProtocol` / `NetworkRequest` / `NetworkResponse` — networking contract
- `StorageProvider` / `StorageKey` — type-safe storage contract
- `AuthProvider` / `AuthToken` / `AuthState` — authentication contract
- `AnalyticsProvider` / `AnalyticsEvent` — analytics contract
- `LoggerProtocol` / `LogLevel` / `LogEntry` — logging contract
- `ConnectivityProvider` / `ConnectivityState` — connectivity contract

### Shared Types

- `SyzygyEnvironment` — debug / staging / production
- `SyzygyConfiguration` — app configuration contract
- `SyzygyBuildInfo` — consumer-injected build metadata
- `SyzygyVersion` — semantic version with comparison support

### Errors

- `SyzygyError` — base error abstract class
- `SyzygyErrorCode` — typed, extensible error codes
- `SyzygyErrorSeverity` — error severity levels

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
- `ConnectivityProvider`: controlled — pass `isOffline` prop (no first-party network detection)
- `SyzygyBuildInfo`: consumer-injected — populate at app startup

## Contributing

Contributions are welcome. Please follow the [Syzygy engineering standards](https://github.com/Syzygy-Hub/.github/tree/main/engineering/standards) when submitting pull requests.

## License

MIT — see [LICENSE](LICENSE)
