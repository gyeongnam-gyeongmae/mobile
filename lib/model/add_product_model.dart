class AddProductModel {
  String title;
  int price;
  String category;
  String content;
  DateTime closeTime;
  int userId;

  AddProductModel({
    required this.title,
    required this.price,
    required this.category,
    required this.content,
    required this.closeTime,
    required this.userId
  });

  Map<String, dynamic> toJson(){
    return {
      'name':title,
      'price':price,
      'category':category,
      'content':content,
      'closedTime':closeTime.toUtc().toIso8601String(),
      'userId':userId
    };
  }
}