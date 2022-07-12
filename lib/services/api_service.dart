// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:convert';

import 'package:fake_store/models/api_response.dart';
import 'package:fake_store/models/cart.dart';
import 'package:fake_store/models/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<dynamic> login(String userN, String pass) {
    return http.post(Uri.parse("$baseUrl/auth/login"),
        body: {'username': userN, 'password': pass}).then((data) {
      if (data.statusCode == 201) {
        final jsonData = json.decode(data.body);

        return Future<dynamic>(jsonData);
      }
      return APIResponse<String>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<String>(error: true, errorMessage: 'An error occured'));
  }

  Future<List<Product>> getProductList() async {
    return http.get(Uri.parse("$baseUrl/products")).then((data) {
      final products = <Product>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        for (var item in jsonData) {
          products.add(Product.fromJson(item));
        }
      }
      return products;
    }).catchError((err) => print(err));
  }

  Future<Product> getSingleProduct(int id) async {
    return http.get(Uri.parse('$baseUrl/products/$id')).then((data) {
      final result = Product();
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final result = Product.fromJson(jsonData);
        return result;
      }
      return result;
    });
  }

  Future<void> updateCart(int cartID, int productID) {
    final tempCart = Cart(userId: cartID, date: DateTime.now(), products: [
      {
        'productId': productID,
        'quantity': 1,
      }
    ]);

    return http
        .put(Uri.parse('$baseUrl/carts/$cartID'), body: json.encode(tempCart))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(jsonData);
      }
    }).catchError((error) => print(error));
  }
}
