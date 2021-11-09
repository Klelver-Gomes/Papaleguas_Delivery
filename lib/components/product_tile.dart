import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/model/product_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';
import 'package:papaleguas_delivery/screens/product_screen.dart';

class ProductTile extends StatefulWidget {
  Product product;

  ProductTile({required this.product});

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return productTile();
  }

  Widget productTile() {
    return ListTile(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductScreen(product: widget.product)));
      },
      leading: Container(
        width: 60,
        height: 60,
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/image/papa_leguas.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
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
    Divider(height: 2);
  }
}
