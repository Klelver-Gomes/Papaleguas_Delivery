import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papaleguas_delivery/blocs/cart_bloc.dart';
import 'package:papaleguas_delivery/components/product_tile.dart';
import 'package:papaleguas_delivery/model/enterprise_model.dart';
import 'package:papaleguas_delivery/model/product_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';
import 'package:papaleguas_delivery/services/product_service.dart';

import 'cart_screen.dart';

class EnterpriseScreen extends StatefulWidget {
  //const EnterpriseScreen({Key? key}) : super(key: key);
  Enterprise enterprise;

  EnterpriseScreen({required this.enterprise});

  @override
  _EnterpriseScreenState createState() => _EnterpriseScreenState();
}

class _EnterpriseScreenState extends State<EnterpriseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.enterprise.name),
      ),
      body: Container(
        decoration: BoxDecoration(
          //image: DecorationImage(image: AssetImage('assets/image/papa_leguas.png')),
          color: Colors.grey.shade300,
        ),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: 200,
              width: double.infinity,
              child: Row(
                children: [
                  _createContainerLeading(widget.enterprise.imageName),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.enterprise.getDiffHour()? "Fechado".toUpperCase()
                                    : widget.enterprise.status.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: widget.enterprise.getDiffHour()? Colors.red: Colors.green),
                              ),

                              Icon(Icons.favorite_border,
                                  color: Colors.red, size: 40),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Encerra às: ' + widget.enterprise.hourCloser,
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow.shade700,
                                  ),
                                  Text(
                                    widget.enterprise.avaliation
                                        .toStringAsFixed(1),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.yellow.shade700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(height: 3, thickness: 2),
                          Text(
                            'Pedido Minimo:  R\$' +
                                widget.enterprise.requestMin.toStringAsFixed(2),
                            style: TextStyle(fontSize: 18),
                          ),
                          Divider(height: 3, thickness: 2),
                          Text(
                            'Entrega:  R\$' +
                                widget.enterprise.valueDelivery
                                    .toStringAsFixed(2) +
                                "  -  " +
                                widget.enterprise.timeDelivery,
                            style: TextStyle(fontSize: 18),
                          ),
                          Divider(height: 3, thickness: 2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder<List<Product>>(
              future: ProductService.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      separatorBuilder: (context, index) =>
                          Divider(height: 2, thickness: 2),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Product product = snapshot.data![index];
                        return ProductTile(product: product);
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ))
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            height: 70,
            child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => CartScreen()));
                },
                child: Icon(Icons.shopping_cart)),
          ),
          Positioned(
            right: 0,
            top: 0,
            child:
                BlocBuilder<CartBloc, List<Product>>(builder: (context, state) {
              int qtd = state.length;
              return qtd == 0
                  ? Container()
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.red,
                      ),
                      width: 28,
                      height: 28,
                      child: Center(
                        child: Text(
                          qtd.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    );
            }),
          ),
        ],
      ),
    );
  }

  Widget _createContainerLeading(String image) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 20, top: 20, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
          width: 120,
          height: 120,
          child: Image.asset(image, fit: BoxFit.fill),
        ),
      ],
    );
  }
}
