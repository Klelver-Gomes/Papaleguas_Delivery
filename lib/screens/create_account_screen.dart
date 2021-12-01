import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/blocs/address_bloc.dart';
import 'package:papaleguas_delivery/blocs/user_bloc.dart';
import 'package:papaleguas_delivery/components/app_component.dart';
import 'package:papaleguas_delivery/components/textFieldsAccount.dart';
import 'package:papaleguas_delivery/components/textFieldsAddress.dart';
import 'package:papaleguas_delivery/components/textFieldsUser.dart';
import 'package:papaleguas_delivery/model/util_model.dart';
import 'package:papaleguas_delivery/screens/enterprise_list_screen.dart';

import 'address_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> userBlocState = GlobalKey<FormState>();
  final GlobalKey<FormState> addressBlocState = GlobalKey<FormState>();
  // late FormState? userBlocState;
  // late FormState? addressBlocState;

  int _currentStep = 0;
  bool _isLoading = false;

  @override
  void initState() {
    // userBlocState = UserBloc.formKey.currentState;
    // addressBlocState = AddressBloc.formKey.currentState;
    super.initState();
  }

  // void createUser() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   FirebaseUser user;
  //
  //   String _email = UserBloc.controllerEmail.text;
  //   String _password = UserBloc.controllerPassword.text;
  //   String _confirmPassword = UserBloc.controllerConfirmPassword.text;
  //
  //   if (_email != "" &&
  //       _password != "" &&
  //       _confirmPassword != "" &&
  //       _password == _confirmPassword) {
  //     user = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: _email, password: _password)
  //         .then((firebaseUser) {
  //       print("Cadastrado com sucesso!" + firebaseUser.user.email);
  //       Navigator.pop(context);
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => EnterpriseScreen()));
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       //Navigator.pop(context);
  //     }).catchError((erro) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       String e = erro.toString();
  //       if (e.contains("ERROR_NETWORK_REQUEST_FAILED")) {
  //         //print("erro: entrou");
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text("Verifique sua conexão com a internet!"),
  //           backgroundColor: Colors.red,
  //         ));
  //       } else if (e.contains("ERROR_EMAIL_ALREADY_IN_USE")) {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text("E-mail já existe!"),
  //           backgroundColor: Colors.red,
  //         ));
  //       }
  //       //print("erro: " + erro.toString());
  //     });
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     if (_password != _confirmPassword) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text("Senhas não coincidem!"),
  //         backgroundColor: Colors.red,
  //       ));
  //     }
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Cadastro'),
        ),
        key: _scaffoldKey,
        body: Stepper(
          steps: _getSteps(),
          currentStep: _currentStep,
          type: StepperType.horizontal,
          onStepContinue: () async {
            final bool isLastStep = _currentStep == _getSteps().length - 1;
            if ((userBlocState.currentState != null && userBlocState.currentState!.validate()) ||
                (addressBlocState.currentState != null && addressBlocState.currentState!.validate())) {
              print(_currentStep.toString());
              if (!isLastStep) {
                setState(() => _currentStep++);
              } else {
                setState(() => _isLoading = true);
                await Future.delayed(Duration(seconds: 2)).then((value) async {
                  setState(() => _isLoading = false);
                  await AppComponent.showAlertMensage(
                      text: 'Cadastro realizado com sucesso', context: context);
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => EnterpriseListScreen(),
                    ),
                  );
                });
              }
            }
          },
          onStepCancel: () => setState(() => _currentStep--),
          controlsBuilder: (context, {onStepCancel, onStepContinue}) => Column(
            children: [
              if (_isLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(),
                ),
              SizedBox(height: 20),
              Row(
                children: [
                  AppComponent.defaultButton(
                    text: 'Confirmar',
                    colorButton: COLOR_BUTTON,
                    voidCallback: onStepContinue,
                  ),
                  SizedBox(width: 10),
                  AppComponent.defaultButton(
                    text: 'Cancelar',
                    colorButton:
                        _currentStep == 0 ? Colors.grey : COLOR_BUTTON_CANCEL,
                    voidCallback: _currentStep == 0 ? null : onStepCancel,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Step> _getSteps() {
    return <Step>[
      Step(
        isActive: _currentStep >= 0,
        title: Text('Dados Pessoais'),
        content: TextFieldsUser(this.userBlocState),
      ),
      Step(
        isActive: _currentStep >= 1,
        title: Text('Endereço'),
        content: TextFieldsAddress(this.addressBlocState),
      ),
      Step(
        isActive: _currentStep >= 2,
        title: Text('Conta'),
        content: TextFieldsAcoount(this.userBlocState),
      ),
    ];
  }
}
