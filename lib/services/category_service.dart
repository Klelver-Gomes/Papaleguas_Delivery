
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:papaleguas_delivery/model/category_model.dart';

class CategoryService {

  static Future<List<Category>> getCategories() async {
    String categoryData = await rootBundle.loadString('assets/json/category.json');
    List<dynamic> categoriesData = jsonDecode(categoryData);
    return categoriesData.map( (json) => Category.fromJson(json)).toList();
  }
}