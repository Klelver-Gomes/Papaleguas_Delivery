import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/model/enterprise_model.dart';
import 'package:papaleguas_delivery/model/product_model.dart';
import 'package:papaleguas_delivery/model/request_model.dart';
import 'package:papaleguas_delivery/model/user_model.dart';
import 'package:papaleguas_delivery/model/util_model.dart';
import 'package:papaleguas_delivery/screens/enterprise_screen.dart';
import 'package:papaleguas_delivery/screens/product_screen.dart';
import 'package:papaleguas_delivery/screens/request_screen.dart';

class RequestTile extends StatefulWidget {
  Request request;
  RequestTile({required this.request});

  @override
  _RequestTileState createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return requestTile();
  }

  Widget requestTile() {
    return ListTile(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => RequestScreen(request: widget.request)));
      },
      leading: Container(
        width: 60,
        height: 60,
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            widget.request.enterprise.imageName,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text('Id: ' + widget.request.id.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
      subtitle: Text(widget.request.enterprise.name, style: TextStyle(fontSize: 16),),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        direction: Axis.horizontal,
        children: [
          Text(
            'R\$' + widget.request.valueTotal.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: COLOR_BUTTON),
          ),
          Icon(Icons.arrow_right_outlined, color: COLOR_BUTTON),

        ],
      ),
    );
    Divider(height: 2);
  }
}
