/// Parameters for requesting a specific page of results.
class PaginationRequest {
  final int pageNumber;
  final int pageSize;
  final String? cursor;

  const PaginationRequest({
    this.pageNumber = 1,
    this.pageSize = 20,
    this.cursor,
  });

  @override
  bool operator ==(Object other) =>
      other is PaginationRequest &&
      pageNumber == other.pageNumber &&
      pageSize == other.pageSize &&
      cursor == other.cursor;

  @override
  int get hashCode => Object.hash(pageNumber, pageSize, cursor);
}
