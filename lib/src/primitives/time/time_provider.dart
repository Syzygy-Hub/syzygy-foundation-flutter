import 'syzygy_timestamp.dart';
import 'syzygy_duration.dart';

/// Abstract time provider — enables deterministic time in tests.
abstract class TimeProvider {
  SyzygyTimestamp now();
  SyzygyDuration since(SyzygyTimestamp timestamp);
}
