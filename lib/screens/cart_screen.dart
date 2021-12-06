import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:papaleguas_delivery/blocs/cart_bloc.dart';
import 'package:papaleguas_delivery/blocs/request_bloc.dart';
import 'package:papaleguas_delivery/components/app_component.dart';
import 'package:papaleguas_delivery/components/product_tile_cart.dart';
import 'package:papaleguas_delivery/model/enterprise_model.dart';
import 'package:papaleguas_delivery/model/product_model.dart';
import 'package:papaleguas_delivery/model/request_model.dart';
import 'package:papaleguas_delivery/model/user_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';
import 'package:papaleguas_delivery/screens/request_screen.dart';

class CartScreen extends StatefulWidget {
  //const CartScreen({Key? key}) : super(key: key);
  Enterprise enterprise;
  UserModel? userModel;
  CartScreen({this.userModel, required this.enterprise});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late double total = 0;
  String optionSelected = 'entrega';
  double valorEntrega = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Meu carrinho'),
        ),
        body: _containerRequest());
  }

  Widget _containerRequest() {
    return BlocBuilder<CartBloc, List<Product>>(
      builder: (context, state) {
        if (state.isNotEmpty) {
          if (optionSelected == 'entrega') {
            total = valorEntrega + state.map((e) => e.price * e.qtd).reduce((value, element) => value + element);
          } else {
            total = state.map((e) => e.price * e.qtd).reduce((value, element) => value + element);
          }
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 0)],
                  borderRadius: BorderRadius.circular(20)),
              width: double.infinity,
              height: 500,
              child: Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                          itemBuilder: (context, index) =>
                              ProductTileCart(product: state[index]),
                          //separatorBuilder: (context, index) => Divider(height: 2, thickness: 2),
                          itemCount: state.length),
                    ),
                  ),
                  Divider(height: 30, thickness: 2),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'PAGAMENTO',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(Icons.monetization_on,
                                  color: Colors.green, size: 30),
                              Icon(Icons.arrow_drop_down, color: Colors.green),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 20, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 180,
                        child: RadioListTile(
                            title: Text(
                              'Entrega',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            value: 'entrega',
                            groupValue: optionSelected,
                            onChanged: (value) {
                              setState(() {
                                optionSelected = value.toString();
                              });
                            }),
                      ),
                      Container(
                        width: 180,
                        child: RadioListTile(
                            title: Text(
                              'Retirada',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            value: 'retirada',
                            groupValue: optionSelected,
                            onChanged: (value) {
                              setState(() {
                                optionSelected = value.toString();
                              });
                            }),
                      ),
                    ],
                  ),
                  Divider(height: 20, thickness: 2),
                  optionSelected == 'entrega'
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Valor da entrega',
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'R\$' + valorEntrega.toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: COLOR_BUTTON),
                              ),
                            ],
                          ),
                        )
                      : ListTile(
                          title: Text(
                            'Rua da empresa',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Bairro da empresa',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            'Numero',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold, color: COLOR_BUTTON),
                          ),
                        )
                ],
              ),
            ),
            Container(
              //padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  blurRadius: 0,
                ),
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Valor total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'R\$' + total.toStringAsFixed(2),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () async {

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text('Pedido realizado!!!', style: TextStyle(fontSize: 21)),
                            backgroundColor: Colors.green));
                        List<Product>? listProducts = BlocProvider.of<CartBloc>(context).state;
                        print(listProducts.toString());
                        Request request = new Request(products: listProducts, valueTotal: total, user: widget.userModel, enterprise: widget.enterprise);
                        await BlocProvider.of<RequestBloc>(context).createRequest(request: request);
                        BlocProvider.of<CartBloc>(context).clearListProduct();
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(
                                      top: 15,
                                      bottom: 15,
                                      left: 10,
                                      right: 10)),
                          backgroundColor: MaterialStateProperty.all<Color>(COLOR_BUTTON),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)))),
                      child: Text('FINALIZAR PEDIDO',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white))),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
