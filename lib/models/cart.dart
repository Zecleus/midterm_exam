class Cart {
  int? id;
  int? userId;
  DateTime? date;
  dynamic products = {
    'productId': int,
    'quantity': int,
  };

  Cart({this.id, this.userId, this.date, this.products});
}
