import 'package:papaleguas_delivery/model/product_model.dart';
import 'package:papaleguas_delivery/model/user_model.dart';

import 'enterprise_model.dart';

class Request {
  int? _id;
  late Enterprise _enterprise;
  UserModel? _user;
  late double _valueTotal;
  late List<Product> _products;

  Request({
    int? id,
    required Enterprise enterprise,
    UserModel? user,
    required double valueTotal,
    required List<Product> products,

  }){
    this._id = id;
    this._enterprise = enterprise;
    this._user = user;
    this._valueTotal = valueTotal;
    this._products = products;
  }

  int? get id => _id;
  set id(int? value) => _id = value;

  Enterprise get enterprise => _enterprise;
  set enterprise(Enterprise value) =>  _enterprise = value;

  UserModel? get user => _user;
  set user(UserModel? value) => _user = value;

  double get valueTotal => _valueTotal;
  set valueTotal(double value) => _valueTotal = value;

  List<Product> get products => _products;
  set products(List<Product> value) => _products = value;

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],
      enterprise: json['enterprise'],
      user: json['user'],
      valueTotal: json['valueTotal'],
      products: json['products'],
    );
  }
}