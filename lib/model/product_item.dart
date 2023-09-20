
class ProductItem{
  final int id;
  final String name;
  final DateTime closedTime;
  final String auctionItemStatus;
  final String status;
  final Map<String, dynamic> address;
  final int likeCount;
  final int viewCount;
  final int price;

  ProductItem({
    required this.id,
    required this.name,
    required this.closedTime,
    required this.auctionItemStatus,
    required this.status,
    required this.address,
    required this.likeCount,
    required this.viewCount,
    required this.price,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'],
      name: json['name'],
      closedTime: DateTime.parse(json['closedTime']),
      auctionItemStatus: json['auctionItemStatus'],
      status: json['status'],
      address: json['address'],
      likeCount: json['like_count'],
      viewCount: json['view_count'],
      price: json['price'],
    );
  }
}