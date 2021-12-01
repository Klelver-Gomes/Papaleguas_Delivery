
import 'package:flutter/cupertino.dart';
import 'package:papaleguas_delivery/model/address_model.dart';

class UserModel {
  late String _email;
  late String _password;
  late String _fullName;
  late String _phone;
  late String _cpf;
  late String _birthDate;
  late AddressModel _address;

  @override
  String toString() {
    return 'UserModel{_email: $_email, _password: $_password, _fullName: $_fullName, _phone: $_phone, _cpf: $_cpf, _birthDate: $_birthDate, _address: $_address}';
  }

  UserModel({
    String? email,
    String? password,
    String? fullName,
    String? phone,
    String? cpf,
    String? birthDate,
    AddressModel? address,
  }){
    this._email = email ?? "";
    this._password = password ?? "";
    this._fullName = fullName ?? "";
    this._phone = phone ?? "";
    this._cpf = cpf ?? "";
    this._birthDate = birthDate ?? "";
    this._address = address ?? AddressModel();
  }

  String get password => _password;
  set password(String value) => _password = value;

  String get fullName => _fullName;
  set fullName(String value) => _fullName = value;

  String get phone => _phone;
  set phone(String value) => _phone = value;

  String get cpf => _cpf;
  set cpf(String value) => _cpf = value;

  String get birthDate => _birthDate;
  set birthDate(String value) => _birthDate = value;

  AddressModel get address => _address;
  set address(AddressModel value) => _address = value;

  String get email => _email;
  set email(String value) => _email = value;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
      fullName: json['fullName'],
      phone: json['_phone'],
      cpf: json['cpf'],
      birthDate: json['birthDate'],
      address: json['address'], // Corrigir
    );
  }
}
