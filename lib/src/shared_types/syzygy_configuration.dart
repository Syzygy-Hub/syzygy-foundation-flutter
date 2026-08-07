import 'syzygy_environment.dart';
import 'syzygy_build_info.dart';
import 'syzygy_version.dart';

/// Abstract app configuration contract. Implementations are consumer-supplied.
abstract class SyzygyConfiguration {
  SyzygyEnvironment get environment;
  String get baseURL;
  SyzygyBuildInfo get buildInfo;
  SyzygyVersion get version;
}
