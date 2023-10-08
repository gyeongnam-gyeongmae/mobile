class ProductSearchModel{
  String keyword;
  String category;
  String nick_name;
  String closed;
  bool search_time;
  bool like;
  bool search_price;
  bool basic;

  ProductSearchModel({
    required this.keyword,
    required this.category,
    required this.nick_name,
    required this.closed,
    required this.search_time,
    required this.like,
    required this.search_price,
    required this.basic
  });

}