import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papaleguas_delivery/model/enterprise_model.dart';
import 'package:papaleguas_delivery/model/product_model.dart';

class EnterpriseBloc extends Cubit<bool> {
  EnterpriseBloc() : super(false);

  late bool _showSearch = false;

  static TextEditingController controllerSearch = TextEditingController();

  bool initSearch() {
    _showSearch = !_showSearch;
    emit(_showSearch);
    return _showSearch;
  }

  Future<List<Enterprise>> getEnterprises() async {
   QuerySnapshot getEnterprises = await FirebaseFirestore.instance.collection('enterprises').get();

   List<Enterprise> listEnterprises = [];
   List<QueryDocumentSnapshot> snapshot = getEnterprises.docs;

   for(var doc in snapshot){
     QuerySnapshot<Map<String, dynamic>> getProducts = await FirebaseFirestore.instance.collection('enterprises').doc(doc.id).collection('products').get();
     List<Product> listProducts = [];

     DocumentSnapshot<Map<String, dynamic>> enterprise = await FirebaseFirestore.instance.collection('enterprises').doc(doc.id).get();

     for(QueryDocumentSnapshot<Map<String, dynamic>> product in getProducts.docs){
       if(product.data().isNotEmpty){
         listProducts.add(Product.fromJson(product.data()));
       }
     }
     Map<String, dynamic>? ent = enterprise.data();
     ent?['products'] = listProducts;
     Enterprise e = Enterprise.fromJson(ent);
     listEnterprises.add(e);
   }
   return listEnterprises;
  }

  Stream<QuerySnapshot> getListEnterprises() {
    return FirebaseFirestore.instance.collection('enterprises').snapshots();
  }
}
