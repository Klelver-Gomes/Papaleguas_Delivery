import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/blocs/user_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFieldsUser extends StatefulWidget {
  TextFieldsUser(this.formKey);
  GlobalKey<FormState> formKey;

  @override
  _TextFieldsUserState createState() => _TextFieldsUserState();
}

class _TextFieldsUserState extends State<TextFieldsUser> {
  FocusNode _focusName = FocusNode();
  FocusNode _focusCpf = FocusNode();
  FocusNode _focusPhone = FocusNode();
  FocusNode _focusBirthDate = FocusNode();


  List<MaskTextInputFormatter> formatters = [
    MaskTextInputFormatter(mask: "(##)#####-####"),
    MaskTextInputFormatter(mask: "###.###.###-##"),
    MaskTextInputFormatter(mask: "##/##/####")
  ];

  @override
  void dispose() {
    print(UserBloc.controllerName.text);
    super.dispose();
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
              focusNode: _focusName,
              textInputAction: TextInputAction.go,
              controller: UserBloc.controllerName,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: "Nome:",
                  icon: Icon(Icons.person),
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
                FocusScope.of(context).requestFocus(_focusCpf);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              focusNode: _focusCpf,
              textInputAction: TextInputAction.go,
              controller: UserBloc.controllerCpf,
              keyboardType: TextInputType.text,
              inputFormatters: [formatters[1]],
              decoration: InputDecoration(
                  labelText: "CPF:",
                  icon: Icon(Icons.badge),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow))),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  //print("valorrr: " + value);
                  return "Campo obrigatório*";
                } else if (value != null && value.length < 14) {
                  return "CPF inválido!";
                } else {
                  //print("valor: " + value);
                  return null;
                }
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_focusPhone);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              focusNode: _focusPhone,
              textInputAction: TextInputAction.go,
              controller: UserBloc.controllerPhone,
              keyboardType: TextInputType.phone,
              inputFormatters: [formatters[0]],
              decoration: InputDecoration(
                  labelText: "Telefone:",
                  icon: Icon(Icons.phone_android_outlined),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow))),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  //print("valorrr: " + value);
                  return "Campo obrigatório*";
                } else if (value != null && value.length < 14) {
                  return "Número inválido!";
                } else {
                  //print("valor: " + value);
                  return null;
                }
              },
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_focusBirthDate);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              focusNode: _focusBirthDate,
              textInputAction: TextInputAction.go,
              controller: UserBloc.controllerBirthDate,
              keyboardType: TextInputType.datetime,
              inputFormatters: [formatters[2]],
              decoration: InputDecoration(
                  labelText: "Data de nascimento:",
                  icon: Icon(Icons.date_range),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)),
              hintText: "dd/mm/aaaa"),
              validator: (value) {
                if (value != null && value.isEmpty) {
                  //print("valorrr: " + value);
                  return "Campo obrigatório*";
                } else if (value != null && value.length < 10) {
                  //print("diaaa " + DateTime.now().year.toString());
                  return "Data inválida!";
                } else {
                  List<String> data;
                  data = value!.split('/');
                  int dia = int.parse(data[0]);
                  int mes = int.parse(data[1]);
                  int ano = int.parse(data[2]);

                  int diaAtual = DateTime.now().day;
                  int mesAtual = DateTime.now().month;
                  int anoAtual = DateTime.now().year;

                  int idade = anoAtual - ano;

                  if (dia < 0 ||
                      dia > 31 ||
                      mes < 0 ||
                      mes > 12 ||
                      ano < 1750 ||
                      ano > DateTime.now().year) {
                    return "Data inválida!";
                  } else {
                    if (mesAtual < mes) {
                      idade--;
                    } else {
                      if (diaAtual < dia) {
                        idade--;
                      }
                    }
                    if (idade < 18) {
                      //print("minhaIdade: " + idade.toString());
                      return "Menor de 18 anos não pode realizar cadastro no app!";
                    }
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
