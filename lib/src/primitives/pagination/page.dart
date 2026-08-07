/// A single page of results from a paginated query.
class Page<T> {
  final List<T> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  const Page({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });

  bool get hasNextPage => pageNumber * pageSize < totalCount;
  bool get hasPreviousPage => pageNumber > 1;
  bool get isEmpty => items.isEmpty;
  int get totalPages =>
      pageSize == 0 ? 0 : (totalCount / pageSize).ceil();

  @override
  bool operator ==(Object other) =>
      other is Page<T> &&
      items == other.items &&
      totalCount == other.totalCount &&
      pageNumber == other.pageNumber &&
      pageSize == other.pageSize;

  @override
  int get hashCode => Object.hash(items, totalCount, pageNumber, pageSize);
}
