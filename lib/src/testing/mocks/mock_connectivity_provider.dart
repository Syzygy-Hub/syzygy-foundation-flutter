import 'dart:async';
import '../../contracts/connectivity/connectivity_provider.dart';
import '../../contracts/connectivity/connectivity_state.dart';

/// Test double for [ConnectivityProvider]. Allows manual state transitions.
class MockConnectivityProvider implements ConnectivityProvider {
  final _controller = StreamController<ConnectivityState>.broadcast();
  ConnectivityState _state;

  MockConnectivityProvider([this._state = ConnectivityState.connected]);

  @override
  Stream<ConnectivityState> get stateStream => _controller.stream;

  @override
  ConnectivityState get state => _state;

  @override
  bool get isConnected => _state.isConnected;

  void setState(ConnectivityState newState) {
    _state = newState;
    _controller.add(newState);
  }

  void dispose() => _controller.close();
}
