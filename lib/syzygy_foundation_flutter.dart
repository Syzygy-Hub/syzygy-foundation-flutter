/// Syzygy Foundation Flutter — runtime barrel.
///
/// Exports all contracts, primitives, shared types, and errors.
/// Does NOT export testing utilities — use syzygy_foundation_flutter_testing.dart
/// for test support types.
library syzygy_foundation_flutter;

// Primitives
export 'src/primitives/id/syzygy_id.dart';
export 'src/primitives/pagination/page.dart';
export 'src/primitives/pagination/pagination_request.dart';
export 'src/primitives/time/syzygy_timestamp.dart';
export 'src/primitives/time/syzygy_duration.dart';
export 'src/primitives/time/time_provider.dart';
export 'src/primitives/validation/validation_result.dart';
export 'src/primitives/validation/validation_rule.dart';

// Contracts — Network
export 'src/contracts/network/network_method.dart';
export 'src/contracts/network/network_request.dart';
export 'src/contracts/network/network_response.dart';
export 'src/contracts/network/network_client_protocol.dart';

// Contracts — Storage
export 'src/contracts/storage/storage_key.dart';
export 'src/contracts/storage/storage_provider.dart';

// Contracts — Auth
export 'src/contracts/auth/auth_token.dart';
export 'src/contracts/auth/auth_state.dart';
export 'src/contracts/auth/auth_provider.dart';

// Contracts — Analytics
export 'src/contracts/analytics/analytics_event.dart';
export 'src/contracts/analytics/analytics_provider.dart';

// Contracts — Logging
export 'src/contracts/logging/log_level.dart';
export 'src/contracts/logging/log_entry.dart';
export 'src/contracts/logging/logger_protocol.dart';

// Contracts — Connectivity
export 'src/contracts/connectivity/connectivity_state.dart';
export 'src/contracts/connectivity/connectivity_provider.dart';

// Shared Types
export 'src/shared_types/syzygy_environment.dart';
export 'src/shared_types/syzygy_configuration.dart';
export 'src/shared_types/syzygy_build_info.dart';
export 'src/shared_types/syzygy_version.dart';

// Errors
export 'src/errors/syzygy_error_severity.dart';
export 'src/errors/syzygy_error_code.dart';
export 'src/errors/syzygy_error.dart';
