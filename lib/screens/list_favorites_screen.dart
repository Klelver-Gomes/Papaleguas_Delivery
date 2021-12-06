import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/model/user_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';

class ListFavoritesScreen extends StatefulWidget {
  //const ListFavoritesScreen({Key? key}) : super(key: key);
  UserModel? user;
  ListFavoritesScreen({this.user});

  @override
  _ListFavoritesScreenState createState() => _ListFavoritesScreenState();
}

class _ListFavoritesScreenState extends State<ListFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Meus Favoritos'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, color: Colors.pink, size: 80),
              Text('Seus favoritos aparecerão aqui', style: TextStyle(fontWeight: FontWeight.bold, color: COLOR_BUTTON, fontSize: 30),),
              SizedBox(height: 10),
              Text('Na tela do estabelecimento, clique no coração para favoritar', style: TextStyle(color: Colors.grey, fontSize: 20), textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}
