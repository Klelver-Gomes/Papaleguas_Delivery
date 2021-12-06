import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papaleguas_delivery/model/enterprise_model.dart';
import 'package:papaleguas_delivery/model/product_model.dart';
import 'package:papaleguas_delivery/model/request_model.dart';
import 'package:papaleguas_delivery/model/user_model.dart';

class RequestBloc extends Cubit<List<Request>> {
  RequestBloc() : super([]);

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void addRequest({required Request request}) {
    state.add(request);
    emit(List.from(state));
  }

  void removeRequest({required Request request}) {
    state.remove(request);
    emit(List.from(state));
  }

  Future<void> createRequest({required Request request}) async {

    CollectionReference createRequest = firebaseFirestore.collection('Requests');
    DocumentReference docRef = await createRequest.doc(request.user!.email).collection(request.enterprise.name).add({
      "valueTotal": request.valueTotal,
    });
    List<Map<String, dynamic>> jsonProducts = [];
    for(Product p in request.products){
      jsonProducts.add(p.toJson(p));
    }
    await docRef.set({
      "id": docRef.id.toString(),
      "valueTotal": request.valueTotal,
      "products": jsonEncode(jsonProducts),
    });
  }

  // Future<List<Request>> getRequestUser({Request? request, required UserModel userModel}) async {
  //     CollectionReference collectionRequest = FirebaseFirestore.instance.collection('requests');
  //     QuerySnapshot<Map<String, dynamic>> docRequest = await collectionRequest.doc(userModel.email).collection('China Mania').get();
  //     List<QueryDocumentSnapshot<Map<String, dynamic>>> doc = docRequest.docs;
  //     doc.map((e) => Request.fromJson(e.data())).toList();
  //
  //   return state;
  // }
}
