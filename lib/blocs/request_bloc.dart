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
      "enterprise": request.enterprise.name,
    });
  }

  Future<List<Request>> getRequests({required String email}) async {
    QuerySnapshot getRequests = await FirebaseFirestore.instance.collection('Requests').get();

    List<Request> listRequests = [];
    List<String> listNameEnterprises = [];
    List<QueryDocumentSnapshot> snapshot = getRequests.docs;

    CollectionReference getEnterprise = FirebaseFirestore.instance.collection('enteprises');
    QuerySnapshot entSnap = await getEnterprise.get();

    for(var nameEnt in entSnap.docs){
      listNameEnterprises.add(nameEnt.id);
    }
    int count = 0;

    for(var doc in snapshot){
      String nameEnterprise = listNameEnterprises[count];
      QuerySnapshot<Map<String, dynamic>> getRequest = await FirebaseFirestore.instance.collection('Requests').doc(email).collection(nameEnterprise).get();
      if(getRequest.docs.isNotEmpty){
        listRequests.add(Request.fromJson(getRequest.docs[count].data()));
      }

    }
    print(listRequests.toString());
    return listRequests;
  }
}
