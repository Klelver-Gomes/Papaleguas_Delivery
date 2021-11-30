import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/blocs/address_bloc.dart';
import 'package:papaleguas_delivery/model/address_model.dart';
import 'package:papaleguas_delivery/model/user_model.dart';

class UserBloc {
  late UserModel _user;

  static TextEditingController controllerName = TextEditingController();
  static TextEditingController controllerCpf = TextEditingController();
  static TextEditingController controllerBirthDate = TextEditingController();
  static TextEditingController controllerPhone = TextEditingController();
  static TextEditingController controllerEmail = TextEditingController();
  static TextEditingController controllerPassword = TextEditingController();
  static TextEditingController controllerConfirmPassword =
      TextEditingController();

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UserModel confirmRegister() {
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
      address: AddressModel(
        street: street,
        district: district,
        number: int.parse(number),
        city: city,
        state: state,
      )
    );
    return _user;
  }
}
