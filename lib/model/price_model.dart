class PriceModel {
  int price;

  PriceModel({
    required this.price,
  });

  Map<String, dynamic> toJson(){
    return {
      'price':price,
    };
  }
}