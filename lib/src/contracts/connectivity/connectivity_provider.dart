import 'connectivity_state.dart';

/// Stream-based connectivity state contract for Flutter.
///
/// Note: This provider exposes controlled state only. Self-detecting
/// implementations (via connectivity_plus etc.) live in syzygy-services-flutter.
/// Foundation provides only the contract and testing mocks.
abstract class ConnectivityProvider {
  Stream<ConnectivityState> get stateStream;
  ConnectivityState get state;
  bool get isConnected;
}
