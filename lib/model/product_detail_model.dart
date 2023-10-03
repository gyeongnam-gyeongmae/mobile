class ProductDetailModel{
  final int id;
  final String name;
  final String nickname;
  final int price;
  final String auctionStatus;
  final DateTime createdTime;
  final DateTime closedTime;
  final DateTime modifiedTime;
  final String category;
  final String content;
  final int likeCount;
  final int viewCount;

  ProductDetailModel({
    required this.id,
    required this.name,
    required this.nickname,
    required this.price,
    required this.auctionStatus,
    required this.createdTime,
    required this.closedTime,
    required this.modifiedTime,
    required this.category,
    required this.content,
    required this.likeCount,
    required this.viewCount
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json){
    return ProductDetailModel(
      id: json['id'],
      name: json['name'],
      nickname: json['nickname'],
      price: json['price'],
      auctionStatus: json['auctionStatus'], 
      createdTime: DateTime.parse(json['createdTime']), 
      closedTime: DateTime.parse(json['closeTime']), 
      modifiedTime: DateTime.parse(json['modifiedTime']), 
      category: json['category'], 
      content: json['content'], 
      likeCount: json['likeCount'], 
      viewCount: json['viewCount']
      );
  }
}