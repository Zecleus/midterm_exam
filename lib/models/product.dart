import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int? id;
  String? title;
  double? price;
  String? category;
  String? description;
  String? image;

  Product(
      {this.id,
      this.title,
      this.price,
      this.category,
      this.description,
      this.image});

  factory Product.fromJson(Map<String, dynamic> item) =>
      _$ProductFromJson(item);
}
