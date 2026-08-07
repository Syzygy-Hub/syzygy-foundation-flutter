import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter_testing.dart';

void main() {
  group('MockConnectivityProvider', () {
    late MockConnectivityProvider provider;

    setUp(() => provider = MockConnectivityProvider());
    tearDown(() => provider.dispose());

    test('default initial state is connected', () {
      expect(provider.isConnected, isTrue);
      expect(provider.state, ConnectivityState.connected);
    });

    test('setState to disconnected updates state and isConnected', () {
      provider.setState(ConnectivityState.disconnected);
      expect(provider.isConnected, isFalse);
      expect(provider.state, ConnectivityState.disconnected);
    });

    test('setState to unknown sets isConnected to false', () {
      provider.setState(ConnectivityState.unknown);
      expect(provider.isConnected, isFalse);
    });

    test('constructor initial state overrides default', () {
      final p = MockConnectivityProvider(ConnectivityState.disconnected);
      addTearDown(p.dispose);
      expect(p.isConnected, isFalse);
    });

    test('stateStream emits new states on setState', () async {
      final states = <ConnectivityState>[];
      final sub = provider.stateStream.listen(states.add);
      provider.setState(ConnectivityState.disconnected);
      provider.setState(ConnectivityState.connected);
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();
      expect(states, [ConnectivityState.disconnected, ConnectivityState.connected]);
    });
  });
}
