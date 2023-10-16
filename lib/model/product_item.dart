
class ProductItem{
  final int id;
  final String nickname;
  final String name;
  final DateTime closedTime;
  final String status;
  final int likeCount;
  final int viewCount;
  final int price;
  final int now_price;
  final String image_url;
  final bool isLike;

  ProductItem({
    required this.id,
    required this.nickname,
    required this.name,
    required this.closedTime,
    required this.status,
    required this.likeCount,
    required this.viewCount,
    required this.price,
    required this.now_price,
    required this.image_url,
    required this.isLike
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'],
      nickname: json['nickname'] ?? '',
      name: json['name'] ?? '',
      closedTime: DateTime.parse(json['closedTime']?? ''),
      status: json['status'] ?? '',
      likeCount: json['like_count'],
      viewCount: json['view_count'],
      price: json['price'],
      now_price: json['now_price'],
      image_url: json['image_url'] ?? '',
      isLike: json['isLike'] ?? true,
    );
  }
}