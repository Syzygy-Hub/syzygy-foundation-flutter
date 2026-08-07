import '../../primitives/time/time_provider.dart';
import '../../primitives/time/syzygy_timestamp.dart';
import '../../primitives/time/syzygy_duration.dart';

/// A [TimeProvider] that returns a fixed, controllable time. Use in tests.
class FixedTimeProvider implements TimeProvider {
  SyzygyTimestamp fixedTime;

  FixedTimeProvider([this.fixedTime = const SyzygyTimestamp(0)]);

  @override
  SyzygyTimestamp now() => fixedTime;

  @override
  SyzygyDuration since(SyzygyTimestamp timestamp) =>
      SyzygyDuration.fromMilliseconds(
        fixedTime.millisecondsSinceEpoch - timestamp.millisecondsSinceEpoch,
      );
}
