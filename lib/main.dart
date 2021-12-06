import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papaleguas_delivery/screens/login_screen.dart';

import 'blocs/cart_bloc.dart';
import 'blocs/enteprise_bloc.dart';
import 'blocs/request_bloc.dart';
import 'model/util_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider (
      providers: [
        BlocProvider(create: (context) => CartBloc(),),
        BlocProvider(create: (context) => EnterpriseBloc(),),
        BlocProvider(create: (context) => RequestBloc(),)
      ],
      child: MaterialApp(
        title: 'Papaléguas Delivery',
        theme: ThemeData(
            primaryColor: COLOR_TEXTFIELD,
            primarySwatch: Colors.indigo,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            iconTheme: IconThemeData(color: COLOR_ICON)),
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
