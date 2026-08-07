/// Syzygy Foundation Flutter — testing barrel.
///
/// Exports all testing utilities (mocks, spies, fixtures) plus re-exports
/// all runtime types for convenience in test files. Import this in your
/// tests instead of importing both packages separately.
library syzygy_foundation_flutter_testing;

// Re-export all runtime types
export 'syzygy_foundation_flutter.dart';

// Mocks
export 'src/testing/mocks/mock_logger.dart';
export 'src/testing/mocks/mock_connectivity_provider.dart';
export 'src/testing/mocks/mock_auth_provider.dart';
export 'src/testing/mocks/mock_storage_provider.dart';
export 'src/testing/mocks/mock_network_client.dart';

// Spies
export 'src/testing/spies/spy_analytics_provider.dart';

// Fixtures
export 'src/testing/fixtures/fixture_provider.dart';
export 'src/testing/fixtures/fixed_time_provider.dart';
