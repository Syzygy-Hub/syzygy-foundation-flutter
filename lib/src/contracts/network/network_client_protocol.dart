import 'network_request.dart';
import 'network_response.dart';

/// Abstract HTTP client contract. Implementations live in syzygy-services-flutter.
abstract class NetworkClientProtocol {
  Future<NetworkResponse> execute(NetworkRequest request);
}
