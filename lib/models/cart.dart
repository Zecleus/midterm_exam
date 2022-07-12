import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  int? id;
  int userId;
  DateTime date;
  List<dynamic> products;

  Cart(
      {this.id,
      required this.userId,
      required this.date,
      required this.products});

  factory Cart.fromJson(Map<String, dynamic> item) => _$CartFromJson(item);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
