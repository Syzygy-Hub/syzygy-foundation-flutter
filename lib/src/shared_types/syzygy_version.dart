/// Semantic version value type.
class SyzygyVersion implements Comparable<SyzygyVersion> {
  final int major;
  final int minor;
  final int patch;
  final String? prerelease;

  const SyzygyVersion(this.major, this.minor, this.patch, {this.prerelease});

  static const current = SyzygyVersion(1, 0, 0);

  @override
  String toString() => prerelease != null
      ? '$major.$minor.$patch-$prerelease'
      : '$major.$minor.$patch';

  @override
  int compareTo(SyzygyVersion other) {
    if (major != other.major) return major.compareTo(other.major);
    if (minor != other.minor) return minor.compareTo(other.minor);
    return patch.compareTo(other.patch);
  }

  @override
  bool operator ==(Object other) =>
      other is SyzygyVersion &&
      major == other.major &&
      minor == other.minor &&
      patch == other.patch &&
      prerelease == other.prerelease;

  @override
  int get hashCode => Object.hash(major, minor, patch, prerelease);
}
