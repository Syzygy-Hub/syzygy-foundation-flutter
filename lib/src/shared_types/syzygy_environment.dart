enum SyzygyEnvironment {
  debug,
  staging,
  production;

  bool get isDebug => this == SyzygyEnvironment.debug;
  bool get isProduction => this == SyzygyEnvironment.production;

  @override
  String toString() => name;
}
