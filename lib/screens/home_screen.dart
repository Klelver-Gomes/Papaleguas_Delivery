import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/blocs/user_bloc.dart';
import 'package:papaleguas_delivery/components/app_component.dart';
import 'package:papaleguas_delivery/components/textFieldsLogin.dart';
import 'package:papaleguas_delivery/model/address_model.dart';
import 'package:papaleguas_delivery/model/user_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';
import 'create_account_screen.dart';
import 'enterprise_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          body: Container(
        //padding: EdgeInsets.only(top: 50),
        color: COLOR_BACKGROUND,
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Image.asset('assets/image/papaleguas_delivery.png',
                          scale: 2.5),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFieldsLogin(),
                              if (_isLoading) CircularProgressIndicator(),
                              SizedBox(height: 20),
                              AppComponent.defaultButton(
                                text: 'Entrar',
                                colorButton: COLOR_BUTTON,
                                function: () async {
                                  if (UserBloc.formKey.currentState != null &&
                                      UserBloc.formKey.currentState!
                                          .validate()) {
                                    setState(() => _isLoading = true);
                                    await Future.delayed(Duration(seconds: 2))
                                        .then((value) async {
                                      setState(() => _isLoading = false);
                                      await AppComponent.showAlertMensage(
                                          text: 'Login realizado com sucesso',
                                          context: context);
                                      UserModel user = UserModel(
                                        fullName: "Klelver Gomes",
                                        cpf: "11415529493",
                                        phone: "83993123416",
                                        birthDate: "23021995",
                                        email: "klelver@net.com",
                                        password: "12345678",
                                        address: AddressModel(
                                            street: "Projetada",
                                            district: "Por do sol",
                                            number: 140,
                                            city: "Cajazeiras",
                                            state: "PB"),
                                      );
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                EnterpriseListScreen(user: user)),
                                        (route) => false,
                                      );
                                    });
                                  }
                                },
                              ),
                              SizedBox(height: 20),
                              InkWell(
                                onTap: () => Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          CreateAccountScreen()),
                                  (route) => false,
                                ),
                                child: Text(
                                  "Esqueceu a senha?",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sua primeira vez aqui? ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () => Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => CreateAccountScreen()),
                            (route) => false,
                          ),
                          child: Text(
                            "Cadastre-se",
                            style: TextStyle(
                                fontSize: 22,
                                color: COLOR_BUTTON,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
