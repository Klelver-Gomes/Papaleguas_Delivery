import 'package:papaleguas_delivery/model/product_model.dart';
import 'package:papaleguas_delivery/model/user_model.dart';

class RequestModel {
  late UserModel _user;
  late double _valueTotal;
  late List<Product> _products;

  RequestModel({
    required UserModel user,
    required double valueTotal,
    required List<Product> products,
  }){
    this._user = user;
    this._valueTotal = valueTotal;
    this._products = products;
  }

  UserModel get user => _user;
  set user(UserModel value) => _user = value;

  double get valueTotal => _valueTotal;
  set valueTotal(double value) => _valueTotal = value;

  List<Product> get products => _products;
  set products(List<Product> value) => _products = value;

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      user: json['user'],
      valueTotal: json['valueTotal'],
      products: json['products'],
    );
  }
}