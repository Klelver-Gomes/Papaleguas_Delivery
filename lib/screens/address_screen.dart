import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/blocs/address_bloc.dart';
import 'package:papaleguas_delivery/components/textFieldsAddress.dart';
import 'package:papaleguas_delivery/model/util_model.dart';
import 'package:papaleguas_delivery/screens/enterprise_list_screen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Endereço'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Center(
          child: GestureDetector(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldsAddress(AddressBloc.formKey),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ButtonTheme(
                      minWidth: 20,
                      height: 45,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(COLOR_BUTTON),
                        ),
                        onPressed: () {
                          //if (AddressBloc.formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EnterpriseListScreen(),
                              ),
                            ); //Verificar como vai ser cadastrado esses dados no banco
                          //}
                        },
                        child: Text(
                          "Confirmar",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: COLOR_TEXT),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(COLOR_BUTTON))
                        : Container(),
                  )
                ],
              ),
            ),
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          ),
        ),
      ),
    );
  }
}
