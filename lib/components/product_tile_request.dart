import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/model/product_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';
import 'package:papaleguas_delivery/screens/product_screen.dart';

class ProductTileRequest extends StatefulWidget {
  Product product;
  ProductTileRequest({required this.product});

  @override
  _ProductTileRequestState createState() => _ProductTileRequestState();
}

class _ProductTileRequestState extends State<ProductTileRequest> {

  @override
  Widget build(BuildContext context) {
    return productTileRequest();
  }

  Widget productTileRequest() {
    return ListTile(
      title: Text(widget.product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
      subtitle: Text(widget.product.description, style: TextStyle(fontSize: 16),),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        direction: Axis.horizontal,
        children: [
          Text(
            'R\$' + widget.product.price.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: COLOR_BUTTON),
          ),
          Icon(Icons.arrow_right_outlined, color: COLOR_BUTTON),
        ],
      ),
    );
  }
}
