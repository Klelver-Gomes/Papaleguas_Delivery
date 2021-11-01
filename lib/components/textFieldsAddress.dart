import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:papaleguas_delivery/blocs/address_bloc.dart';
import 'package:papaleguas_delivery/blocs/user_bloc.dart';

class TextFieldsAddress extends StatefulWidget {
  TextFieldsAddress(this.formKey);
  GlobalKey<FormState> formKey;

  @override
  _TextFieldsAddressState createState() => _TextFieldsAddressState();
}

class _TextFieldsAddressState extends State<TextFieldsAddress> {
  FocusNode _focusStreet = FocusNode();
  FocusNode _focusNumber = FocusNode();
  FocusNode _focusDistrict = FocusNode();
  FocusNode _focusCity = FocusNode();
  FocusNode _focusState = FocusNode();

  @override
  void initState() {
    print(UserBloc.controllerName.text + ' FieldsAddress');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              focusNode: _focusStreet,
              textInputAction: TextInputAction.go,
              controller: AddressBloc.controllerStreet,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Rua:",
                  //icon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow))),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  //print("valorrr: " + value);
                  return "Campo obrigatório*";
                } else {
                  //print("valor: " + value);
                  return null;
                }
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_focusNumber);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              focusNode: _focusNumber,
              textInputAction: TextInputAction.go,
              controller: AddressBloc.controllerNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Número:",
                  //icon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow))),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  //print("valorrr: " + value);
                  return "Campo obrigatório*";
                } else {
                  //print("valor: " + value);
                  return null;
                }
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_focusDistrict);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              focusNode: _focusDistrict,
              textInputAction: TextInputAction.go,
              controller: AddressBloc.controllerDistrict,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Bairro:",
                  //icon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow))),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  //print("valorrr: " + value);
                  return "Campo obrigatório*";
                } else {
                  //print("valor: " + value);
                  return null;
                }
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_focusCity);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              focusNode: _focusCity,
              textInputAction: TextInputAction.go,
              controller: AddressBloc.controllerCity,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Cidade:",
                  //icon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow))),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  //print("valorrr: " + value);
                  return "Campo obrigatório*";
                } else {
                  //print("valor: " + value);
                  return null;
                }
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_focusState);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: TextFormField(
              focusNode: _focusState,
              textInputAction: TextInputAction.go,
              controller: AddressBloc.controllerState,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "UF:",
                  //icon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow))),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  //print("valorrr: " + value);
                  return "Campo obrigatório*";
                } else {
                  //print("valor: " + value);
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
