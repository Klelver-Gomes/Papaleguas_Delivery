import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papaleguas_delivery/blocs/cart_bloc.dart';
import 'package:papaleguas_delivery/model/product_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';
import 'package:papaleguas_delivery/screens/product_screen.dart';

class ProductTileCart extends StatefulWidget {
  Product product;
  ProductTileCart({required this.product});

  @override
  _ProductTileCartState createState() => _ProductTileCartState();
}

class _ProductTileCartState extends State<ProductTileCart> {
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
      leading: Wrap(
        direction: Axis.horizontal,
        children: [
          IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () async {
            await showDialog(context: context, builder: (context) => AlertDialog(
              title: Text('Atenção'),
              content: Text('Remover produto?', style: TextStyle(fontSize: 16)),
              actions: [
                TextButton(onPressed: (){
                  BlocProvider.of<CartBloc>(context).removeProduct(product: widget.product);
                  Navigator.pop(context);
                }, child: Text('OK', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18))),
              ],
            ));
          }, tooltip: 'Remover', constraints: BoxConstraints(maxWidth: 30),
          ),
          IconButton(icon: Icon(Icons.edit, color: COLOR_BUTTON), onPressed: (){
            BlocProvider.of<CartBloc>(context).removeProduct(product: widget.product);
          }, tooltip: 'Editar', constraints: BoxConstraints(maxWidth: 30)),
        ],
      ),
      title: Text(widget.product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
      subtitle: Text(widget.product.description, style: TextStyle(fontSize: 16),),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        direction: Axis.horizontal,
        children: [
          Text('x' + widget.product.qtd.toString() + "   ", style: TextStyle(fontWeight: FontWeight.bold,)),
          Text(
            'R\$' + (widget.product.price*widget.product.qtd).toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: COLOR_BUTTON),
          ),
        ],
      ),
    );
    Divider(height: 2);
  }
}
