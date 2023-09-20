
import 'package:mobile/model/product_item.dart';
import 'package:mobile/model/product_page_info.dart';

class ProductPage {
  final List<ProductItem> auctionItemFirstViewPage;
  final ProductPageInfo productPageInfo;

  ProductPage({
    required this.auctionItemFirstViewPage,
    required this.productPageInfo});

  factory ProductPage.fromJson(Map<String, dynamic> json){
    return ProductPage(
      auctionItemFirstViewPage: (json['auctionItemFirstViewPage'] as List)
        .map((e) => ProductItem.fromJson(e))
        .toList(),
      productPageInfo: ProductPageInfo.fromJson(json['auctionItemPaginationDto']));
  }
}