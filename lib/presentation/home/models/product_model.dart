import 'package:aplikasi_sipos/core/extensions/int_ext.dart';

import 'product_category.dart';

class ProductModel {
  final String image;
  final String name;
  final ProductCategory category;
  final int price;

  ProductModel({
    required this.image,
    required this.name,
    required this.category,
    required this.price,
  });

  String get priceFormat => price.currencyFormatRp;
}
