enum ConnectivityState {
  connected,
  disconnected,
  unknown;

  bool get isConnected => this == ConnectivityState.connected;
}
