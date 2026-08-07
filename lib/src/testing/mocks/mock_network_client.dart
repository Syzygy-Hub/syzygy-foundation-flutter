import '../../contracts/network/network_client_protocol.dart';
import '../../contracts/network/network_request.dart';
import '../../contracts/network/network_response.dart';

/// Test double for [NetworkClientProtocol]. Queue responses or set an error.
class MockNetworkClient implements NetworkClientProtocol {
  final List<NetworkResponse> responses = [];
  final List<NetworkRequest> requests = [];
  Object? error;

  @override
  Future<NetworkResponse> execute(NetworkRequest request) async {
    requests.add(request);
    if (error != null) throw error!;
    if (responses.isEmpty) {
      throw StateError('MockNetworkClient: no response queued');
    }
    return responses.removeAt(0);
  }
}
