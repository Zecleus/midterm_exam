// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:convert';
import 'dart:html';

import 'package:fake_store/models/api_response.dart';
import 'package:fake_store/models/cart.dart';
import 'package:fake_store/models/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<dynamic> login(String userN, String pass) {
    return http.post(Uri.parse("$baseUrl/auth/login"),
        body: {'username': userN, 'password': pass}).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        return jsonData;
      }
    }).catchError((error) => print(error));
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

  Future<void> updateCart(int cartID, int productID) async {
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

  Future<dynamic> getAllCategories() async {
    return http.get(Uri.parse('$baseUrl/products/category')).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return jsonData;
      }
    }).catchError((err) => print(err));
  }

  Future<dynamic> getCategory(String category) {
    return http
        .get(Uri.parse('$baseUrl/products/category/$category'))
        .then((data) {
      final categoryProducts = <Product>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        for (var item in jsonData) {
          categoryProducts.add(Product.fromJson(item));
        }
      }
      return categoryProducts;
    });
  }

  Future<Cart> getSingleCart(int id) async {
    return http.get(Uri.parse('$baseUrl/carts/$id')).then((data) {
      final result = Cart(date: DateTime.now(), products: [], userId: 1);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final result = Cart.fromJson(jsonData);
        return result;
      }
      return result;
    });
  }

  Future<void> deleteCart(int id) async {
    return http.delete(Uri.parse('$baseUrl/carts/$id')).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        print(data.statusCode);
        print(jsonData);
      }
    }).catchError((err) => print(err));
  }
}
