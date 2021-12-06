import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papaleguas_delivery/blocs/cart_bloc.dart';
import 'package:papaleguas_delivery/blocs/enteprise_bloc.dart';
import 'package:papaleguas_delivery/blocs/request_bloc.dart';
import 'package:papaleguas_delivery/blocs/user_bloc.dart';
import 'package:papaleguas_delivery/components/app_component.dart';
import 'package:papaleguas_delivery/components/request_tile.dart';
import 'package:papaleguas_delivery/constants/categories.dart';
import 'package:papaleguas_delivery/model/category_model.dart';
import 'package:papaleguas_delivery/model/enterprise_model.dart';
import 'package:papaleguas_delivery/model/product_model.dart';
import 'package:papaleguas_delivery/model/user_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';
import 'package:papaleguas_delivery/screens/enterprise_screen.dart';
import 'package:papaleguas_delivery/screens/list_favorites_screen.dart';
import 'package:papaleguas_delivery/screens/list_request_screen.dart';
import 'package:papaleguas_delivery/screens/login_screen.dart';
import 'package:papaleguas_delivery/screens/profile_screen.dart';
import 'package:papaleguas_delivery/screens/request_screen.dart';
import 'package:papaleguas_delivery/screens/settings_screen.dart';
import 'package:papaleguas_delivery/services/category_service.dart';
import 'package:papaleguas_delivery/services/enterprise_service.dart';

class HomeScreen extends StatefulWidget {
  //const EnterpriseListScreen({Key? key}) : super(key: key);
  // String email;
  // HomeScreen({required this.email});
  UserModel? user;
  HomeScreen({this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      //await UserBloc().getUser(widget.user!.email);
      //await RequestBloc().getRequestUser(request: null, userModel: widget.user!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size page = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
            child: Stack(
              children: [
                Column(
                  children: [
                    UserAccountsDrawerHeader(

                      accountName: Text(
                        widget.user != null ? widget.user!.fullName : "Usuario",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      accountEmail: Text(
                        widget.user != null ? widget.user!.email : "Email do usuario",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    listTileMenu("Perfil", Icon(Icons.account_box, color: Colors.pink, size: 30), ProfileScreen(user: widget.user!)),
                    listTileMenu("Pedidos", Icon(Icons.confirmation_num, color: Colors.pink, size: 30), ListRequestScreen(user: widget.user)),
                    listTileMenu("Favoritos", Icon(Icons.favorite, color: Colors.pink, size: 30), ListFavoritesScreen(user: widget.user)),
                    listTileMenu("Configurações",Icon(Icons.settings, color: Colors.pink, size: 30),SettingsScreen(user: widget.user!)),
                    Divider(height: 2, thickness: 3),
                    listTileMenu("Sair", Icon(Icons.logout, color: Colors.pink, size: 30), LoginScreen()),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Powered by:", style: TextStyle(fontSize: 18, color: Colors.grey.shade600),),
                      Text("Group Papaleguas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: COLOR_BUTTON),),
                      Text("Version: 1.0.0", style: TextStyle(fontSize: 16, color: Colors.grey.shade600),),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            )
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: EdgeInsets.all(10),
            height: 65,
            color: COLOR_BUTTON,
            child: Row(
              children: [
                Icon(Icons.location_on, color: Colors.white, size: 30),
                SizedBox(width: 10),
                Text(
                  widget.user != null
                      ? widget.user!.address.street +
                          ", " +
                          widget.user!.address.number.toString() +
                          ", " +
                          widget.user!.address.district +
                          "\n" +
                          widget.user!.address.city +
                          "-" +
                          widget.user!.address.state
                      : "Endereço do usuario",
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
                          onPressed: () =>
                              BlocProvider.of<EnterpriseBloc>(context).initSearch(),
                          icon: Icon(Icons.arrow_back),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              EnterpriseBloc.controllerSearch.clear(),
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
              child: containerListEnterprise(page),
            ),
          ],
        ),
      ),
    );
  }

  Widget listTileMenu(String text, Widget icon, Widget screen) {
    return ListTile(
      leading: icon,
      title: Text(
        text,
        style: TextStyle(
            color: COLOR_BUTTON, fontWeight: FontWeight.bold, fontSize: 22),
      ),
      onTap: () async {
        if(text.toLowerCase() == 'sair'){
          await FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => screen), (route) => true);
        }else {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => screen));
        }
      },
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

  // Widget containerEnterprise(Size size) {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: EnterpriseBloc().getListEnterprises(),
  //     builder: (context, snapshot) {
  //       switch (snapshot.connectionState) {
  //         case ConnectionState.none:
  //         case ConnectionState.waiting:
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         default:
  //           List<DocumentSnapshot> docs = snapshot.data!.docs;
  //           return ListView.builder(
  //             itemCount: docs.length,
  //             itemBuilder: (context, index) {
  //                 return Wrap(
  //                   runSpacing: 10,
  //                   spacing: 10,
  //                   alignment: WrapAlignment.center,
  //                   children: snapshot.data.map(
  //                           (enterprise) => GestureDetector(
  //                             onTap: () => Navigator.push(context,
  //                                   CupertinoPageRoute(builder: (context) =>
  //                                       EnterpriseScreen(enterprise: enterprise, userModel: widget.user),
  //                                   ),
  //                                 ),
  //                             child: Container(
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(15),
  //                                   boxShadow: [BoxShadow(blurRadius: 2)],
  //                                   color: Colors.white,
  //                                 ),
  //                                 height: 200,
  //                                 width: size.width * 0.30,
  //                                 child: Column(
  //                                   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Container(
  //                                       decoration: BoxDecoration(
  //                                           boxShadow: [
  //                                             BoxShadow(blurRadius: 2),
  //                                             BoxShadow(
  //                                                 color: Colors.blueGrey.shade400),
  //                                           ],
  //                                           borderRadius: BorderRadius.only(
  //                                               topLeft: Radius.circular(15),
  //                                               topRight: Radius.circular(15))),
  //                                       child: ClipRRect(
  //                                         borderRadius: BorderRadius.only(
  //                                             topLeft: Radius.circular(15),
  //                                             topRight: Radius.circular(15)),
  //                                         child: Image.asset(
  //                                           enterprise.imageName,
  //                                           width: double.infinity,
  //                                           height: 110,
  //                                           fit: BoxFit.fill,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                     Expanded(
  //                                       child: Padding(
  //                                         padding:
  //                                         const EdgeInsets.fromLTRB(5, 10, 5, 10),
  //                                         child: Column(
  //                                           mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                           crossAxisAlignment: CrossAxisAlignment.start,
  //                                           children: [
  //                                             Text(
  //                                               enterprise.name,
  //                                               style: TextStyle(
  //                                                   fontWeight: FontWeight.bold,
  //                                                   fontSize: 19,
  //                                                   color: Colors.pink),
  //                                             ),
  //                                             Row(
  //                                               mainAxisAlignment:
  //                                               MainAxisAlignment.spaceBetween,
  //                                               children: [
  //                                                 Text(
  //                                                   enterprise.category,
  //                                                   style: TextStyle(
  //                                                       fontSize: 14,
  //                                                       fontWeight: FontWeight.bold),
  //                                                 ),
  //                                                 Row(
  //                                                   children: [
  //                                                     Icon(
  //                                                       Icons.star,
  //                                                       color: Colors.amber.shade700,
  //                                                       size: 18,
  //                                                     ),
  //                                                     Text(
  //                                                       enterprise.avaliation
  //                                                           .toString(),
  //                                                       style: TextStyle(
  //                                                           fontSize: 15,
  //                                                           color: Colors.amber
  //                                                               .shade700,
  //                                                           fontWeight: FontWeight
  //                                                               .bold),
  //                                                     ),
  //                                                   ],
  //                                                 )
  //                                               ],
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     )
  //                                   ],
  //                                 )
  //                             ),
  //                           )
  //                   ).toList(),
  //                 );
  //               }
  //           );
  //       }
  //     },
  //   );
  // }

    Widget containerListEnterprise(Size size) {
      return FutureBuilder<List<Enterprise>>(
        future: EnterpriseBloc().getEnterprises(),
        builder: (context, snapshot) {
          //print(snapshot.data.toString());
          if (snapshot.hasData) {
            return Wrap(
              runSpacing: 10,
              spacing: 10,
              alignment: WrapAlignment.center,
              children: snapshot.data!.map((enterprise) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              EnterpriseScreen(enterprise: enterprise, userModel: widget.user),
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
                                                enterprise.avaliation.toString(),
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
