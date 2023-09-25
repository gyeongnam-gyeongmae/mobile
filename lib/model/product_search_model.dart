class ProductSearchModel{
  String keyword;
  String category;
  String nick_name;
  bool closed;
  bool search_time;
  bool like;
  bool search_price;

  ProductSearchModel({
    required this.keyword,
    required this.category,
    required this.nick_name,
    required this.closed,
    required this.search_time,
    required this.like,
    required this.search_price,
  });

}