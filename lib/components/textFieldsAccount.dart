import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/blocs/user_bloc.dart';

class TextFieldsAcoount extends StatefulWidget {
  TextFieldsAcoount(this.formKey);
  GlobalKey<FormState> formKey;

  @override
  _TextFieldsAcoountState createState() => _TextFieldsAcoountState();
}

class _TextFieldsAcoountState extends State<TextFieldsAcoount> {
  FocusNode _focusEmail = FocusNode();
  FocusNode _focusPassword = FocusNode();
  FocusNode _focusConfirmPassword = FocusNode();

  bool _showPassword = false;
  bool _showPasswordConfirm = false;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
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
                  icon: Icon(Icons.email),
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
            padding: const EdgeInsets.only(top: 15),
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
                  icon: Icon(Icons.lock),
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
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_focusConfirmPassword);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: TextFormField(
              focusNode: _focusConfirmPassword,
              controller: UserBloc.controllerConfirmPassword,
              keyboardType: TextInputType.text,
              obscureText: _showPasswordConfirm == false ? true : false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)),
                  icon: Icon(Icons.lock),
                  labelText: "Confirme a senha:",
                  suffixIcon: GestureDetector(
                    child: Icon(_showPasswordConfirm == false
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onTap: () {
                      setState(() {
                        _showPasswordConfirm = !_showPasswordConfirm;
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
