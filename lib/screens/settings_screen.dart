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

  bool _showNewPassword = false;
  bool _showNewPasswordConfirm = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showTextFields = false;

  TextEditingController controllerOldPassword = TextEditingController();
  TextEditingController controllerNewPassword = TextEditingController();
  TextEditingController controllerNewConfirmPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Minha Conta",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
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
                          obscureText: true,
                          controller:
                          TextEditingController(text: widget.user.password),
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
                Visibility(child: textFieldsAccount(), visible: _showTextFields),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: !_showTextFields? MainAxisAlignment.center: MainAxisAlignment.spaceAround,
                  children: [
                    Visibility(
                      visible: _showTextFields,
                      child: AppComponent.defaultButton(
                        text: 'Salvar',
                        colorButton: COLOR_BUTTON,
                        function: () async {
                          if(_formKey.currentState!.validate()){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Salvo com sucesso'),
                                backgroundColor: Colors.green));
                            await Future.delayed(Duration(seconds: 1));
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                    AppComponent.defaultButton(
                      text: _showTextFields? 'Cancelar': 'Alterar senha',
                      colorButton: _showTextFields? Colors.red: COLOR_BUTTON,
                      function: () async {
                        setState(() {
                          _showTextFields = !_showTextFields;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );


  }

  Widget textFieldsAccount(){
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Alterar senha",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: controllerOldPassword,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Senha antiga:",
                  border: OutlineInputBorder()),
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
            SizedBox(height: 10),
            TextFormField(
              controller: controllerNewPassword,
              keyboardType: TextInputType.text,
              obscureText: _showNewPassword == false ? true : false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)),
                  labelText: "Senha nova:",
                  suffixIcon: GestureDetector(
                    child: Icon(_showNewPassword == false
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onTap: () {
                      setState(() {
                        _showNewPassword = !_showNewPassword;
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
            SizedBox(height: 10),
            TextFormField(
              controller: controllerNewConfirmPassword,
              keyboardType: TextInputType.text,
              obscureText: _showNewPasswordConfirm == false ? true : false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)),
                  labelText: "Confirme a nova senha:",
                  suffixIcon: GestureDetector(
                    child: Icon(_showNewPasswordConfirm == false
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onTap: () {
                      setState(() {
                        _showNewPasswordConfirm = !_showNewPasswordConfirm;
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
          ],
        ),
      ),
    );
  }
}
