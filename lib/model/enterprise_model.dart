
import 'dart:convert';

import 'package:papaleguas_delivery/model/product_model.dart';

class Enterprise {
  late String _name;
  late String _description;
  late String _category;
  late String _imageName;
  //late List<Map<String, dynamic>> _listProducts;


  Enterprise({
    required String name,
    required String category,
    required String description,
    required String imageName,
   // required List<Map<String, dynamic>> products,

  }) {
    this._name = name;
    this._category = category;
    this._description = description;
    this._imageName = imageName;
    //this._listProducts = products;
  }

  String get name => _name;
  set name(String value) => _name = value;

  String get category => _category;
  set category(String value) => _category = value;

  String get description => _description;
  set description(String value) => _description = value;

  String get imageName => _imageName;
  set imageName(String value) => _imageName = value;

  // List<Map<String, dynamic>> get listProducts => _listProducts;
  // set listProducts(List<Map<String, dynamic>> value) => _listProducts = value;


  factory Enterprise.fromJson(Map<String, dynamic> json) {
    // print(json['products'].toString());
    return Enterprise(
      name: json['name'],
      category: json['category'],
      description: json['description'],
      imageName: json['imageName'],
      //products: json['products'],
    );
  }

}