# Changelog

All notable changes to `syzygy-foundation-flutter` are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

---

## [1.0.0] - 2026-08-06

### Added

#### Primitives
- `SyzygyID<T>` — generic typed identifier wrapping a UUID string; value equality; `generate()` factory
- `SyzygyPage<T>` — paginated result wrapper with `hasNextPage`, `hasPreviousPage`, `isEmpty`, `totalPages`
- `PaginationRequest` — page number, page size, optional cursor; defaults to page 1, size 20
- `SyzygyTimestamp` — immutable millisecond-precision Unix-epoch instant; `Comparable`; `toDateTime()`; `now()` factory
- `SyzygyDuration` — immutable millisecond-precision duration; `.fromSeconds`, `.fromMinutes`, `.fromHours` factories
- `TimeProvider` — abstract class for injectable clock abstraction
- `ValidationResult` — `Valid` / `Invalid(messages)` sealed class; `isValid` computed property; `ValidationResultX` extension
- `ValidationRule<T>` — abstract single-method validation contract

#### Contracts — Network
- `NetworkMethod` — `get`, `post`, `put`, `patch`, `delete`, `head` enum
- `NetworkRequest` — outgoing request value type; `Uint8List` body
- `NetworkResponse` — incoming response value type; `isSuccess`, `isClientError`, `isServerError`
- `NetworkClientProtocol` — abstract `Future<NetworkResponse> execute(NetworkRequest)` method

#### Contracts — Storage
- `StorageKey<T>` — typed key with `identifier` and optional `defaultValue`
- `StorageProvider` — abstract `get`/`set`/`remove`/`clear` with serializer/deserializer callbacks

#### Contracts — Auth
- `AuthToken` — access token, optional refresh token, optional expiry; `isExpired` computed property
- `AuthState` — sealed class: `Unauthenticated`, `Authenticated`, `AuthExpired`, `Refreshing`; `AuthStateX` extension
- `AuthProvider` — `Stream<AuthState>` + `authenticate`, `refresh`, `signOut` abstract methods

#### Contracts — Analytics
- `AnalyticsEvent` — named event with `Map<String, Object?>` properties and timestamp
- `AnalyticsProvider` — abstract `track`, `identify`, `reset` contract

#### Contracts — Logging
- `LogLevel` — `debug`, `info`, `warning`, `error`, `critical` enum
- `LogEntry` — structured entry with level, message, timestamp, `Map<String, String>` metadata, optional `Exception`
- `LoggerProtocol` — abstract `log(entry)` + `debug`, `info`, `warning`, `error`, `critical` convenience methods

#### Contracts — Connectivity
- `ConnectivityState` — `connected`, `disconnected`, `unknown` sealed class with `isConnected`
- `ConnectivityProvider` — abstract `Stream<ConnectivityState>` + `isConnected` snapshot

#### Shared Types
- `SyzygyEnvironment` — `debug`, `staging`, `production` sealed class; `isDebug`, `isProduction`
- `SyzygyConfiguration` — abstract top-level app configuration
- `SyzygyBuildInfo` — consumer-injected app metadata (name, bundle ID, build number, version)
- `SyzygyVersion` — semantic version value type; `Comparable`; `SyzygyVersion.current` = `1.0.0`

#### Errors
- `SyzygyErrorSeverity` — `info`, `warning`, `error`, `critical` enum
- `SyzygyErrorCode` — typed error code; predefined: `unknown`, `cancelled`, `timeout`, `unauthenticated`, `forbidden`, `notFound`, `serverError`, `networkUnavailable`, `decodingFailed`, `encodingFailed`
- `SyzygyError` — abstract class implementing `Exception`; `code`, `message`, `severity`, `underlyingError`

#### Testing (`syzygy_foundation_flutter_testing.dart` — `dev_dependencies` only)
- `MockLogger` — records `LogEntry` instances; filterable by `LogLevel`; `clear()`
- `MockConnectivityProvider` — `StreamController`-backed; `setState()` for test control
- `MockAuthProvider` — tracks `refreshCallCount`, `signOutCallCount`; configurable `refreshResult`
- `MockStorageProvider` — in-memory map; accessible for direct assertions
- `MockNetworkClient` — FIFO response queue; `requests` list; configurable `error`
- `SpyAnalyticsProvider` — records `trackedEvents`, `identifiedUsers`, `resetCallCount`; `eventsNamed` filter
- `FixtureProvider<T>` — abstract fixture factory protocol
- `FixedTimeProvider` — deterministic `TimeProvider` with mutable `fixedTime`

#### Repository
- `syzygy.yml` manifest added

### Changed
- CI lint step now fetches `analysis_options.yaml` from `Syzygy-Hub/.github/main/engineering/tooling/flutter/`
- CI coverage step added: `flutter test --coverage` + lcov line coverage summary written to `GITHUB_STEP_SUMMARY`
- README rewritten to Syzygy engineering standard

[Unreleased]: https://github.com/Syzygy-Hub/syzygy-foundation-flutter/compare/1.0.0...HEAD
[1.0.0]: https://github.com/Syzygy-Hub/syzygy-foundation-flutter/releases/tag/1.0.0
