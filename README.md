[![Flutter](https://img.shields.io/badge/Flutter-Dart-7F77DD?style=flat)](https://flutter.dev/) [![Dart](https://img.shields.io/badge/Dart-3.0-1D9E75?logo=dart&logoColor=white&style=flat)](https://dart.dev) [![CI](https://img.shields.io/github/actions/workflow/status/Syzygy-Hub/syzygy-foundation-flutter/ci.yml?label=ci&style=flat)](https://github.com/Syzygy-Hub/syzygy-foundation-flutter/actions/workflows/ci.yml) [![Version](https://img.shields.io/badge/version-1.0.0-D85A30?style=flat)](https://github.com/Syzygy-Hub/syzygy-foundation-flutter/releases) [![License](https://img.shields.io/badge/License-MIT-green?style=flat)](LICENSE)

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/Syzygy-Hub/.github/main/brand/syzygy-banner-dark-1200.png">
  <img src="https://raw.githubusercontent.com/Syzygy-Hub/.github/main/brand/syzygy-banner-light-1200.png" alt="Syzygy" width="600">
</picture>

# syzygy-foundation-flutter

Contracts, primitives, and shared types for the Flutter Syzygy ecosystem — zero implementation, zero dependencies.

## About

syzygy-foundation-flutter is the base layer every other Syzygy Flutter library depends on. It defines the abstract classes that Services implements, the value types that UI and Core consume, and the error types the whole stack shares. Nothing in Foundation has behaviour beyond property storage — no network calls, no platform APIs, no business logic. Swap any implementation in Services or Core by extending these contracts; Foundation never needs to change.

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
  syzygy_foundation_flutter: ^1.0.0
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

**Used by:** syzygy-ui-flutter, syzygy-core-flutter, syzygy-services-flutter

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

## Releases

Releases follow the Syzygy commit-message flow:

1. Create branch `release/X.X.X`
2. Bump version in manifest and `syzygy.yml`
3. Update `CHANGELOG.md`
4. Open PR → `main`
5. Get approval and merge with commit message starting with **`release:`** (e.g. `release: 1.0.0`)
6. CI detects the `release:` prefix → reads version from `syzygy.yml` → creates git tag and GitHub Release automatically

See the [Syzygy Release Standard](https://github.com/Syzygy-Hub/.github/blob/main/engineering/standards/release-standard.md) for full details.

## License

MIT — see [LICENSE](LICENSE)
