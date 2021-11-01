import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papaleguas_delivery/screens/home_screen.dart';

import 'blocs/cart_bloc.dart';
import 'blocs/enteprise_bloc.dart';
import 'model/util_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider (
      providers: [
        BlocProvider(create: (context) => CartBloc(),),
        BlocProvider(create: (context) => EnterpriseBloc(),)
      ],
      child: MaterialApp(
        title: 'Papaléguas Delivery',
        theme: ThemeData(
            primaryColor: COLOR_TEXTFIELD,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            iconTheme: IconThemeData(color: COLOR_ICON)),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
