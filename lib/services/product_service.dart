

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:papaleguas_delivery/model/product_model.dart';

class ProductService {

  static Future<List<Product>> getProducts() async {
    String productData = await rootBundle.loadString('assets/json/product.json');
    List<dynamic> productsData = jsonDecode(productData);
    return productsData.map( (json) => Product.fromJson(json)).toList();
  }

}