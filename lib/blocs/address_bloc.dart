
import 'package:flutter/material.dart';

class AddressBloc {

  static TextEditingController controllerStreet = TextEditingController();
  static TextEditingController controllerNumber = TextEditingController();
  static TextEditingController controllerDistrict = TextEditingController();
  static TextEditingController controllerCity = TextEditingController();
  static TextEditingController controllerState = TextEditingController();

  static final formKey = GlobalKey<FormState>();
}