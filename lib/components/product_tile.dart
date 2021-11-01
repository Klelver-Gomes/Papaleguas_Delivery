import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/model/product_model.dart';

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
      title: Text(widget.product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      subtitle: Text(widget.product.description, style: TextStyle(fontSize: 16),),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        direction: Axis.vertical,
        children: [
          Text(
            'R\$' + widget.product.price.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue.shade900),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('x' + _count.toString()),
              SizedBox(width: 10),
              InkWell(
                  child: Icon(Icons.add_box, color: Colors.green, size: 30),
                  onTap: () {
                    setState(() {
                      _count++;
                    });
                  }),
              SizedBox(width: 5),
              InkWell(
                child: Icon(Icons.remove_circle, color: Colors.red, size: 30),
                onTap: () {
                  setState(() {
                    _count--;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
    Divider(height: 2);
  }
}
