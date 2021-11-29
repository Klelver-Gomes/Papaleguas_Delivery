import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papaleguas_delivery/blocs/cart_bloc.dart';
import 'package:papaleguas_delivery/blocs/enteprise_bloc.dart';
import 'package:papaleguas_delivery/components/app_component.dart';
import 'package:papaleguas_delivery/constants/categories.dart';
import 'package:papaleguas_delivery/model/category_model.dart';
import 'package:papaleguas_delivery/model/enterprise_model.dart';
import 'package:papaleguas_delivery/model/product_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';
import 'package:papaleguas_delivery/screens/enterprise_screen.dart';
import 'package:papaleguas_delivery/services/category_service.dart';
import 'package:papaleguas_delivery/services/enterprise_service.dart';

class EnterpriseListScreen extends StatefulWidget {
  const EnterpriseListScreen({Key? key}) : super(key: key);

  @override
  _EnterpriseListScreenState createState() => _EnterpriseListScreenState();
}

class _EnterpriseListScreenState extends State<EnterpriseListScreen> {
  @override
  Widget build(BuildContext context) {
    Size page = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Estabelecimentos'),
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<EnterpriseBloc>(context).initSearch();
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        drawer: Drawer(
            child: Column(
              children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/image/iconeUser.png',
                    fit: BoxFit.cover,
                    color: Colors.white,
                  ),
                ),
                accountName: Text(
                  "Nome Usuario",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                ),
                accountEmail: Text(
                  "Email Usuario",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                ),
              ),
              listTileMenu("Perfil", Icon(Icons.account_box, color: Colors.pink, size: 30)),
              listTileMenu("Pedidos", Icon(Icons.confirmation_num, color: Colors.pink, size: 30)),
              listTileMenu("Favoritos", Icon(Icons.favorite, color: Colors.pink, size: 30)),
              listTileMenu("Configurações", Icon(Icons.settings, color: Colors.pink, size: 30)),
              Divider(height: 2, thickness: 3),
              listTileMenu("Sair", Icon(Icons.logout, color: Colors.pink, size: 30)),
            ],
          )),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: EdgeInsets.all(10),
            height: 60,
            color: COLOR_BUTTON,
            child: Row(
              children: [
                Icon(Icons.location_on, color: Colors.white, size: 30),
                SizedBox(width: 10),
                Text(
                  "Endereço do usuario",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          children: [
            BlocBuilder<EnterpriseBloc, bool>(
              builder: (context, state) {
                if (state) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: EnterpriseBloc.controllerSearch,
                      decoration: InputDecoration(
                        labelText: 'Pesquisa',
                        border: OutlineInputBorder(),
                        prefixIcon: IconButton(
                          onPressed: () => BlocProvider.of<EnterpriseBloc>(context).initSearch(),
                          icon: Icon(Icons.arrow_back),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => EnterpriseBloc.controllerSearch.clear(),
                          icon: Icon(Icons.close),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 20, right: 10, left: 10),
              width: page.width,
              height: 110,
              //color: Colors.red,
              child: containerCategories(page),
            ),
            Container(
              padding: EdgeInsets.only(top: 40),
              width: page.width,
              height: page.height,
              //color: Colors.green,
              child: containerEnterprise(page),
            ),
          ],
        ),

      ),
    );
  }

  Widget listTileMenu(String text, Widget icon) {
    return ListTile(
      leading: icon,
      title: Text(
        text,
        style: TextStyle(
            color: COLOR_BUTTON, fontWeight: FontWeight.bold, fontSize: 22),
      ),
      onTap: () {},
    );
  }

  Widget containerCategories(Size size) {
    return FutureBuilder<List<Category>>(
        future: CategoryService.getCategories(),
        builder: (context, snapshot) {
          //print(snapshot.data.toString());
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!
                  .map(
                    (category) => Container(
                      width: 105,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: COLOR_BUTTON, width: 3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 70,
                            width: 70,
                            child: Image.asset(category.icon, scale: 1.2),
                          ),
                          Text(category.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget containerEnterprise(Size size) {
    return FutureBuilder<List<Enterprise>>(
      future: EnterpriseService.getEnterprise(),
      builder: (context, snapshot) {
        //print(snapshot.data.toString());
        if (snapshot.hasData) {
          return Wrap(
            runSpacing: 10,
            spacing: 10,
            alignment: WrapAlignment.center,
            children: snapshot.data!
                .map(
                  (enterprise) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            EnterpriseScreen(enterprise: enterprise),
                      ),
                    ),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(blurRadius: 2)],
                          color: Colors.white,
                        ),
                        height: 200,
                        width: size.width * 0.30,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(blurRadius: 2),
                                    BoxShadow(color: Colors.blueGrey.shade400),
                                  ],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                child: Image.asset(
                                  enterprise.imageName,
                                  width: double.infinity,
                                  height: 110,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      enterprise.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                          color: Colors.pink),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          enterprise.category,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber.shade700,
                                              size: 18,
                                            ),
                                            Text(
                                              '4,8',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.amber.shade700,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                )
                .toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
