import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter.dart';

void main() {
  group('NetworkRequest', () {
    test('default timeoutSeconds is 30', () {
      const req = NetworkRequest(
        url: 'https://example.com',
        method: NetworkMethod.get,
      );
      expect(req.timeoutSeconds, 30.0);
    });

    test('custom timeoutSeconds is respected', () {
      const req = NetworkRequest(
        url: 'https://example.com',
        method: NetworkMethod.post,
        timeoutSeconds: 60.0,
      );
      expect(req.timeoutSeconds, 60.0);
    });

    test('headers default to empty map', () {
      const req = NetworkRequest(
        url: 'https://example.com',
        method: NetworkMethod.get,
      );
      expect(req.headers, isEmpty);
    });
  });

  group('NetworkResponse', () {
    NetworkResponse response(int code) =>
        NetworkResponse(statusCode: code, data: Uint8List(0));

    test('isSuccess true for 200', () => expect(response(200).isSuccess, isTrue));
    test('isSuccess true for 299', () => expect(response(299).isSuccess, isTrue));
    test('isSuccess false for 300', () => expect(response(300).isSuccess, isFalse));
    test('isSuccess false for 400', () => expect(response(400).isSuccess, isFalse));
    test('isSuccess false for 500', () => expect(response(500).isSuccess, isFalse));

    test('isClientError true for 400', () => expect(response(400).isClientError, isTrue));
    test('isClientError true for 499', () => expect(response(499).isClientError, isTrue));
    test('isClientError false for 500', () => expect(response(500).isClientError, isFalse));
    test('isClientError false for 200', () => expect(response(200).isClientError, isFalse));

    test('isServerError true for 500', () => expect(response(500).isServerError, isTrue));
    test('isServerError true for 599', () => expect(response(599).isServerError, isTrue));
    test('isServerError false for 400', () => expect(response(400).isServerError, isFalse));
  });
}
