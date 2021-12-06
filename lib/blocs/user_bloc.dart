import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/blocs/address_bloc.dart';
import 'package:papaleguas_delivery/model/address_model.dart';
import 'package:papaleguas_delivery/model/user_model.dart';

class UserBloc {
  late UserModel _user;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static TextEditingController controllerName = TextEditingController();
  static TextEditingController controllerCpf = TextEditingController();
  static TextEditingController controllerBirthDate = TextEditingController();
  static TextEditingController controllerPhone = TextEditingController();
  static TextEditingController controllerEmail = TextEditingController(text: 'klelvercz@gmail.com');
  static TextEditingController controllerPassword = TextEditingController(text: '12345678');
  static TextEditingController controllerConfirmPassword = TextEditingController();

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<UserModel> confirmRegister() async {
    final String fullName = controllerName.text;
    final String cpf = controllerCpf.text;
    final String birthDate = controllerBirthDate.text;
    final String phone = controllerPhone.text;
    final String email = controllerEmail.text;
    final String password = controllerPassword.text;
    final String street = AddressBloc.controllerStreet.text;
    final String district = AddressBloc.controllerDistrict.text;
    final String number = AddressBloc.controllerNumber.text;
    final String city = AddressBloc.controllerCity.text;
    final String state = AddressBloc.controllerState.text;

    _user = UserModel(
      fullName: fullName,
      cpf: cpf,
      birthDate: birthDate,
      phone: phone,
      email: email,
      password: password,
      address: Address(
        street: street,
        district: district,
        number: int.parse(number),
        city: city,
        state: state,
      )
    );
    CollectionReference creatUser = firebaseFirestore.collection('Users');
    await creatUser.doc(_user.email).set({
      "email": _user.email,
      "password": _user.password,
      "fullName": _user.fullName,
      "cpf": _user.cpf,
      "phone": _user.phone,
      "birthDate": _user.birthDate,
    });
    await creatUser.doc(_user.email).collection('Address').doc('Casa').set({
      "street": _user.address.street,
      "district": _user.address.district,
      "number": _user.address.number,
      "city": _user.address.city,
      "state": _user.address.state,
    });
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).catchError(print);
    return _user;
  }

  Future<bool> login(String email, String password) async {
    UserCredential userCredencial = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    if(userCredencial.user != null){
      return true;
    }
    return false;
  }

  Future<UserModel> getUser(String email) async {
    CollectionReference getUser =  FirebaseFirestore.instance.collection('Users');
    DocumentSnapshot docSnap = await getUser.doc(email).get();
    Map<String, dynamic> userData = docSnap.data()as Map<String, dynamic>;
    DocumentSnapshot addressData = await getUser.doc(email).collection('Address').doc('Casa').get();
    Map<String, dynamic> jsonAddress = addressData.data()as Map<String, dynamic>;
    Address address = Address.fromJson(jsonAddress);
    userData['address'] = address;
    UserModel userModel = UserModel.fromJson(userData);
    return userModel;
  }

}
