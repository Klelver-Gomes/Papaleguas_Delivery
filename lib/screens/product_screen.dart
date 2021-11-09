import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/model/product_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';

class ProductScreen extends StatefulWidget {
  //const ProductScreen({Key? key}) : super(key: key);
  Product product;

  ProductScreen({required this.product});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detalhes do ítem"),
        ),
        body: Stack(
          //mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    blurRadius: 0,
                  ),
                ]),
                //width: double.infinity,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            child:
                            Icon(Icons.add_box, color: COLOR_BUTTON, size: 50),
                            onTap: () {
                              setState(() {
                                _count++;
                              });
                            }),
                        SizedBox(width: 15),
                        Text(
                          _count.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40),
                        ),
                        SizedBox(width: 15),
                        InkWell(
                          child: Icon(Icons.remove_circle_sharp,
                              color: COLOR_BUTTON, size: 50),
                          onTap: () {
                            if (_count > 1)
                              setState(() {
                                _count--;
                              });
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10)),
                            backgroundColor: MaterialStateProperty.all<Color>(COLOR_BUTTON),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)))),

                        child: Text('Adicionar   -   ' + 'R\$' + (widget.product.price*_count).toStringAsFixed(2),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white))),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Image.asset('assets/image/papa_leguas.png',
                      height: 200, width: 200, fit: BoxFit.fill),
                  Text(
                    widget.product.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text(
                    widget.product.description,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'R\$' + widget.product.price.toStringAsFixed(2),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: COLOR_BUTTON),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Observações',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.pink),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, top: 10),
                    child: Scrollbar(
                      child: TextFormField(
                        textInputAction: TextInputAction.go,
                        maxLines: 8,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
