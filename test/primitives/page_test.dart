import 'package:test/test.dart';
import 'package:syzygy_foundation_flutter/syzygy_foundation_flutter.dart';

void main() {
  group('Page', () {
    test('isEmpty is true when items is empty', () {
      const page = Page<int>(items: [], totalCount: 0, pageNumber: 1, pageSize: 20);
      expect(page.isEmpty, isTrue);
    });

    test('isEmpty is false when items has content', () {
      const page = Page<int>(items: [1, 2], totalCount: 2, pageNumber: 1, pageSize: 20);
      expect(page.isEmpty, isFalse);
    });

    test('totalPages rounds up for non-exact division', () {
      const page = Page<int>(items: [], totalCount: 55, pageNumber: 1, pageSize: 20);
      expect(page.totalPages, 3);
    });

    test('totalPages is exact for exact division', () {
      const page = Page<int>(items: [], totalCount: 40, pageNumber: 1, pageSize: 20);
      expect(page.totalPages, 2);
    });

    test('hasNextPage is true when more items remain', () {
      const page = Page<int>(items: [], totalCount: 50, pageNumber: 1, pageSize: 20);
      expect(page.hasNextPage, isTrue);
    });

    test('hasNextPage is false on last page', () {
      const page = Page<int>(items: [], totalCount: 20, pageNumber: 1, pageSize: 20);
      expect(page.hasNextPage, isFalse);
    });

    test('hasPreviousPage is false on page 1', () {
      const page = Page<int>(items: [], totalCount: 100, pageNumber: 1, pageSize: 20);
      expect(page.hasPreviousPage, isFalse);
    });

    test('hasPreviousPage is true on page 2', () {
      const page = Page<int>(items: [], totalCount: 100, pageNumber: 2, pageSize: 20);
      expect(page.hasPreviousPage, isTrue);
    });
  });

  group('PaginationRequest', () {
    test('default values are pageNumber=1 pageSize=20 cursor=null', () {
      const req = PaginationRequest();
      expect(req.pageNumber, 1);
      expect(req.pageSize, 20);
      expect(req.cursor, isNull);
    });

    test('custom values are respected', () {
      const req = PaginationRequest(pageNumber: 3, pageSize: 10, cursor: 'next');
      expect(req.pageNumber, 3);
      expect(req.pageSize, 10);
      expect(req.cursor, 'next');
    });
  });
}
