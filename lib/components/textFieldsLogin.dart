import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/blocs/user_bloc.dart';
import 'package:papaleguas_delivery/model/util_model.dart';

class TextFieldsLogin extends StatefulWidget {
  const TextFieldsLogin({Key? key}) : super(key: key);

  @override
  _TextFieldsLoginState createState() => _TextFieldsLoginState();
}

class _TextFieldsLoginState extends State<TextFieldsLogin> {
  FocusNode _focusEmail = FocusNode();
  FocusNode _focusPassword = FocusNode();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: UserBloc.formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              focusNode: _focusEmail,
              textInputAction: TextInputAction.go,
              controller: UserBloc.controllerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "Email:",
                  icon: Icon(Icons.email, color: COLOR_BUTTON),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow))),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  //print("valorrr: " + value);
                  return "Campo obrigatório*";
                } else if (value != null && !value.contains("@") ||
                    value != null && !value.contains(".com")) {
                  return "E-mail inválido*";
                } else {
                  //print("valor: " + value);
                  return null;
                }
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_focusPassword);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            child: TextFormField(
              focusNode: _focusPassword,
              textInputAction: TextInputAction.go,
              controller: UserBloc.controllerPassword,
              keyboardType: TextInputType.text,
              obscureText: _showPassword == false ? true : false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)),
                  labelText: "Senha:",
                  icon: Icon(Icons.lock, color: COLOR_BUTTON),
                  suffixIcon: GestureDetector(
                    child: Icon(_showPassword == false
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  )),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Campo obrigatório*";
                } else if (value != null && value.length < 8) {
                  return "Senha deve conter pelo menos 8 caracteres*";
                } else if (value != null && value.contains(" ")) {
                  return "Senha não pode conter espaços*";
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
