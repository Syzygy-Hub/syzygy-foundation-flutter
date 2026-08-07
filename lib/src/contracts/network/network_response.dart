import 'dart:typed_data';

/// Represents an incoming HTTP response.
class NetworkResponse {
  final int statusCode;
  final Uint8List data;
  final Map<String, String> headers;

  const NetworkResponse({
    required this.statusCode,
    required this.data,
    this.headers = const {},
  });

  bool get isSuccess => statusCode >= 200 && statusCode <= 299;
  bool get isClientError => statusCode >= 400 && statusCode <= 499;
  bool get isServerError => statusCode >= 500 && statusCode <= 599;

  @override
  bool operator ==(Object other) =>
      other is NetworkResponse &&
      statusCode == other.statusCode &&
      headers == other.headers;

  @override
  int get hashCode => Object.hash(statusCode, headers);
}
