import 'dart:typed_data';
import '../../contracts/auth/auth_token.dart';
import '../../contracts/network/network_request.dart';
import '../../contracts/network/network_response.dart';
import '../../contracts/network/network_method.dart';
import '../../contracts/analytics/analytics_event.dart';
import '../../contracts/logging/log_entry.dart';
import '../../contracts/logging/log_level.dart';
import '../../primitives/time/syzygy_timestamp.dart';
import '../../primitives/id/syzygy_id.dart';
import '../../shared_types/syzygy_version.dart';

/// Abstract fixture provider protocol for custom fixture implementations.
abstract class FixtureProvider<T> {
  T fixture();
}

/// Static factory methods for common fixture objects.
abstract class Fixtures {
  Fixtures._();

  static SyzygyID<T> syzygyId<T>() => const SyzygyID('fixture-id-00000000');

  static AuthToken authToken() => const AuthToken(
        accessToken: 'fixture-access-token',
        refreshToken: 'fixture-refresh-token',
      );

  static NetworkRequest networkRequest() => const NetworkRequest(
        url: 'https://fixture.syzygy.dev/api',
        method: NetworkMethod.get,
      );

  static NetworkResponse networkResponse() => NetworkResponse(
        statusCode: 200,
        data: Uint8List(0),
        headers: const {},
      );

  static AnalyticsEvent analyticsEvent() =>
      AnalyticsEvent(name: 'test_event');

  static LogEntry logEntry() => const LogEntry(
        level: LogLevel.info,
        message: 'fixture log message',
        timestamp: SyzygyTimestamp(0),
      );

  static SyzygyVersion syzygyVersion() => const SyzygyVersion(1, 0, 0);
}
