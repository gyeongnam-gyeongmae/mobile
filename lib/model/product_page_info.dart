
class ProductPageInfo{
  final int currentPage;
  final int itemCount;
  final int itemsPerPage;
  final int totalItems;
  final int totalPages;

  ProductPageInfo({
    required this.currentPage,
    required this.itemCount,
    required this.itemsPerPage,
    required this.totalItems,
    required this.totalPages,
  });

  factory ProductPageInfo.fromJson(Map<String, dynamic> json) {
    return ProductPageInfo(
      currentPage: json['currentPage'],
      itemCount: json['itemCount'],
      itemsPerPage: json['itemsPerPage'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
    );
  }
}