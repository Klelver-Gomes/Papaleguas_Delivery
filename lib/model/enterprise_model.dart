
import 'dart:convert';

import 'package:papaleguas_delivery/model/product_model.dart';
import 'package:papaleguas_delivery/model/request_model.dart';

class Enterprise {
  late String _name;
  late String _description;
  late String _category;
  late String _imageName;
  late String _status;
  late String _hourCloser;
  late double _avaliation;
  late double _valueDelivery;
  late String _timeDelivery;
  late double _requestMin;
  final List<RequestModel> _listRequest = [];
  late List<Product> _listProducts;

  Enterprise({
    required String name,
    required String category,
    required String description,
    required String imageName,
    required String status,
    required String hourCloser,
    required double avaliation,
    required double valueDelivery,
    required String timeDelivery,
    required double requestMin,
    List<Product>? listProduct,

  }) {
    this._name = name;
    this._category = category;
    this._description = description;
    this._imageName = imageName;
    this._status = status;
    this._hourCloser = hourCloser;
    this._avaliation = avaliation;
    this._valueDelivery = valueDelivery;
    this._timeDelivery = timeDelivery;
    this._requestMin = requestMin;
    this._listProducts = listProducts;
  }

  String get name => _name;
  set name(String value) => _name = value;

  String get category => _category;
  set category(String value) => _category = value;

  String get description => _description;
  set description(String value) => _description = value;

  String get imageName => _imageName;
  set imageName(String value) => _imageName = value;

  double get requestMin => _requestMin;
  set requestMin(double value) => _requestMin = value;

  String get status => _status;
  set status(String value) => _status = value;

  String get hourCloser => _hourCloser;
  set hourCloser(String value) =>  _hourCloser = value;

  double get avaliation => _avaliation;
  set avaliation(double value) =>  _avaliation = value;

  double get valueDelivery => _valueDelivery;
  set valueDelivery(double value) => _valueDelivery = value;

  String get timeDelivery => _timeDelivery;
  set timeDelivery(String value) => _timeDelivery = value;

  List<RequestModel> get listRequest => _listRequest;

  List<Product> get listProducts => _listProducts;
  set listProducts(List<Product> value) => _listProducts = value;


  bool getDiffHour(){
    int hour = int.parse(this.hourCloser.split(":")[0]);
    int minute = int.parse(this.hourCloser.split(":")[1]);
    int hourNow = DateTime.now().hour;
    int minuteNow = DateTime.now().minute;
    if(hourNow >= hour && minuteNow >= minute){
      return true;
    }
    return false;
  }



  factory Enterprise.fromJson(Map<String, dynamic> json) {
    // print(json['products'].toString());
    return Enterprise(
      name: json['name'],
      category: json['category'],
      description: json['description'],
      imageName: json['imageName'],
      status: json['status'],
      hourCloser: json['hourCloser'],
      avaliation: json['avaliation'],
      valueDelivery: json['valueDelivery'],
      timeDelivery: json['timeDelivery'],
      requestMin: json['requestMin'],
      listProduct: json['listProduct'],
    );
  }


}