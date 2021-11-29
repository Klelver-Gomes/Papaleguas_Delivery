
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:papaleguas_delivery/model/enterprise_model.dart';

class EnterpriseService{

  static Future<List<Enterprise>> getEnterprise() async {
    String enterpriseData = await rootBundle.loadString('assets/json/enterprise.json');
    List<dynamic> enterprisesData = jsonDecode(enterpriseData);
    return enterprisesData.map( (json) => Enterprise.fromJson(json)).toList();
  }


}