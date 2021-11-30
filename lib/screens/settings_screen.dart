import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/blocs/user_bloc.dart';
import 'package:papaleguas_delivery/components/app_component.dart';
import 'package:papaleguas_delivery/components/textFieldsAccount.dart';
import 'package:papaleguas_delivery/model/user_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';

class SettingsScreen extends StatefulWidget {
  //const SettingsScreen({Key? key}) : super(key: key);
  UserModel user;
  SettingsScreen({required this.user});



  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<FormState> userBlocState = GlobalKey<FormState>();

  FocusNode _focusEmail = FocusNode();
  FocusNode _focusPassword = FocusNode();
  FocusNode _focusConfirmPassword = FocusNode();

  bool _showPassword = false;
  bool _showPasswordConfirm = false;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Configurações"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Dados da Conta",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.edit, color: COLOR_BUTTON),
                                  onPressed: () {
                                    setState(() {

                                    });
                                  },
                                  tooltip: 'Editar',
                                  constraints: BoxConstraints(maxWidth: 30)),
                            ],
                          ),
                        ),
                        TextField(
                          textInputAction: TextInputAction.go,
                          controller:
                          TextEditingController(text: widget.user.email),
                          decoration: InputDecoration(
                              enabled: false,
                              labelText: "Email",
                              border:
                              OutlineInputBorder(borderSide: BorderSide())),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          textInputAction: TextInputAction.go,
                          controller:
                          TextEditingController(text: widget.user.phone),
                          decoration: InputDecoration(
                              enabled: false,
                              labelText: "Senha",
                              border:  OutlineInputBorder(borderSide: BorderSide())),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                AppComponent.defaultButton(
                  text: 'Salvar',
                  colorButton: COLOR_BUTTON,
                  function: () async {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Salvo com sucesso'),
                        backgroundColor: Colors.green));
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );


  }

  Widget textFieldsAccount(){
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
