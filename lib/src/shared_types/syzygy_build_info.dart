/// Consumer-injected build metadata. Foundation does not read from platform APIs.
class SyzygyBuildInfo {
  final String appName;
  final String bundleId;
  final String buildNumber;
  final String version;

  const SyzygyBuildInfo({
    required this.appName,
    required this.bundleId,
    required this.buildNumber,
    required this.version,
  });

  @override
  bool operator ==(Object other) =>
      other is SyzygyBuildInfo &&
      appName == other.appName &&
      bundleId == other.bundleId &&
      buildNumber == other.buildNumber &&
      version == other.version;

  @override
  int get hashCode => Object.hash(appName, bundleId, buildNumber, version);
}
