import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter_testing.dart';

void main() {
  group('MockNetworkClient', () {
    late MockNetworkClient client;

    setUp(() => client = MockNetworkClient());

    const request = NetworkRequest(
      url: 'https://example.com',
      method: NetworkMethod.get,
    );

    NetworkResponse response(int code) =>
        NetworkResponse(statusCode: code, data: Uint8List(0));

    test('execute returns queued response', () async {
      client.responses.add(response(200));
      final result = await client.execute(request);
      expect(result.statusCode, 200);
    });

    test('execute consumes responses in FIFO order', () async {
      client.responses.add(response(200));
      client.responses.add(response(404));
      final first = await client.execute(request);
      final second = await client.execute(request);
      expect(first.statusCode, 200);
      expect(second.statusCode, 404);
    });

    test('execute records the request', () async {
      client.responses.add(response(200));
      await client.execute(request);
      expect(client.requests, hasLength(1));
      expect(client.requests.first.url, 'https://example.com');
    });

    test('execute throws when error is set', () async {
      client.error = StateError('network error');
      expect(client.execute(request), throwsStateError);
    });

    test('execute throws StateError when queue is empty', () async {
      expect(client.execute(request), throwsStateError);
    });
  });
}
