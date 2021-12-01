import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:papaleguas_delivery/blocs/user_bloc.dart';
import 'package:papaleguas_delivery/components/app_component.dart';
import 'package:papaleguas_delivery/model/user_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';

class ProfileScreen extends StatefulWidget {
  //const ProfileScreen({Key? key}) : super(key: key);
  UserModel user;
  ProfileScreen({required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _editPerson = false;
  bool _editAddress = false;

  List<MaskTextInputFormatter> formatters = [
    MaskTextInputFormatter(mask: "(##)#####-####"),
    MaskTextInputFormatter(mask: "###.###.###-##"),
    MaskTextInputFormatter(mask: "##/##/####")
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Perfil"),
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
                                "Dados Pessoais",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.edit, color: COLOR_BUTTON),
                                  onPressed: () {
                                    setState(() {
                                      _editPerson = !_editPerson;
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
                              TextEditingController(text: widget.user.fullName),
                          decoration: InputDecoration(
                              enabled: _editPerson,
                              labelText: "Nome",
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          textInputAction: TextInputAction.go,
                          controller:
                              TextEditingController(text: widget.user.cpf),
                          decoration: InputDecoration(
                              enabled: _editPerson,
                              labelText: "CPF",
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                          inputFormatters: [formatters[1]],
                        ),
                        SizedBox(height: 10),
                        TextField(
                          textInputAction: TextInputAction.go,
                          controller:
                              TextEditingController(text: widget.user.phone),
                          decoration: InputDecoration(
                              enabled: _editPerson,
                              labelText: "Celular",
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                          inputFormatters: [formatters[0]],
                        ),
                        SizedBox(height: 10),
                        TextField(
                          textInputAction: TextInputAction.go,
                          controller:
                              TextEditingController(text: widget.user.birthDate),
                          decoration: InputDecoration(
                              enabled: _editPerson,
                              labelText: "Data de Nascimento",
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                          inputFormatters: [formatters[2]],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Endereço",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                                icon: Icon(Icons.edit, color: COLOR_BUTTON),
                                onPressed: () {
                                  setState(() {
                                    _editAddress = !_editAddress;
                                  });
                                },
                                tooltip: 'Editar',
                                constraints: BoxConstraints(maxWidth: 30)),
                          ],
                        ),
                        TextField(
                          textInputAction: TextInputAction.go,
                          controller: TextEditingController(
                              text: widget.user.address.street),
                          decoration: InputDecoration(
                              enabled: _editAddress,
                              labelText: "Rua",
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          textInputAction: TextInputAction.go,
                          controller: TextEditingController(
                              text: widget.user.address.district),
                          decoration: InputDecoration(
                              enabled: _editAddress,
                              labelText: "Bairro",
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          textInputAction: TextInputAction.go,
                          controller: TextEditingController(
                              text: widget.user.address.number.toString()),
                          decoration: InputDecoration(
                              enabled: _editAddress,
                              labelText: "Numero",
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          textInputAction: TextInputAction.go,
                          controller: TextEditingController(
                              text: widget.user.address.city),
                          decoration: InputDecoration(
                              enabled: _editAddress,
                              labelText: "Cidade",
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          textInputAction: TextInputAction.go,
                          controller: TextEditingController(
                              text: widget.user.address.state),
                          decoration: InputDecoration(
                              enabled: _editAddress,
                              labelText: "Estado",
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
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
}
