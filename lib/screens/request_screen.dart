import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/components/product_tile_request.dart';
import 'package:papaleguas_delivery/model/request_model.dart';

class RequestScreen extends StatefulWidget {
  //const RequestScreen({Key? key}) : super(key: key);
  Request request;
  RequestScreen({required this.request});

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pedido: #' + widget.request.id.toString()),
      ),
      body: _containerRequest(),
    );
  }

  Widget _containerRequest(){
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
                    itemBuilder: (context, index) => ProductTileRequest(product: widget.request.products[index]),

                  )
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
                    child: Text('Entrega ou Retirada'),
                  ),
                ],
              ),
              Divider(height: 20, thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Valor total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'R\$' + widget.request.valueTotal.toStringAsFixed(2),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

}
