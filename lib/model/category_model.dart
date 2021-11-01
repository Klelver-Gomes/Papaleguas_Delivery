

import 'package:flutter/cupertino.dart';

class Category {

  late String _name;
  late String _icon;

  Category ({
    required String name,
    required String icon,
  }) {
    this._name = name;
    this._icon = icon;
  }

  String get name => _name;
  set name(String value) => _name = value;

  String get icon => _icon;
  set icon(String value) => _icon = value;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      icon: json['icon'],
    );
  }
}