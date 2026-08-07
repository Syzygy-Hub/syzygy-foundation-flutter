import 'dart:typed_data';
import 'network_method.dart';

/// Represents an outgoing HTTP request.
class NetworkRequest {
  final String url;
  final NetworkMethod method;
  final Map<String, String> headers;

  /// Raw request body bytes. Excluded from equality for simplicity.
  final Uint8List? body;
  final double timeoutSeconds;

  const NetworkRequest({
    required this.url,
    required this.method,
    this.headers = const {},
    this.body,
    this.timeoutSeconds = 30.0,
  });

  @override
  bool operator ==(Object other) =>
      other is NetworkRequest &&
      url == other.url &&
      method == other.method &&
      headers == other.headers &&
      timeoutSeconds == other.timeoutSeconds;

  @override
  int get hashCode => Object.hash(url, method, headers, timeoutSeconds);
}
