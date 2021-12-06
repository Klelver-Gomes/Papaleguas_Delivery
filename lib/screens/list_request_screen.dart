import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/model/user_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';

class ListRequestScreen extends StatefulWidget {
  //const ListRequestScreen({Key? key}) : super(key: key);
  UserModel? user;
  ListRequestScreen({this.user});

  @override
  _ListRequestScreenState createState() => _ListRequestScreenState();
}

class _ListRequestScreenState extends State<ListRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Meus Pedidos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.confirmation_number, color: Colors.pink, size: 80),
            Text('Seus pedidos aparecerão aqui', style: TextStyle(fontWeight: FontWeight.bold, color: COLOR_BUTTON, fontSize: 30),),
            SizedBox(height: 10),
            Text('Você ainda não tem nenhum pedido', style: TextStyle(color: Colors.grey, fontSize: 20), textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }

  // Widget listRequests(){
  //   return ListView.builder(itemBuilder: (context, index) {
  //
  //   });
  // }

}
