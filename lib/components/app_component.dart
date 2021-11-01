

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papaleguas_delivery/model/util_model.dart';

class AppComponent {
  static Widget defaultButton({
    Color colorButton = COLOR_BUTTON,
    required String text,
    Function? function,
    VoidCallback? voidCallback}) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: ButtonTheme(
        minWidth: 20,
        height: 45,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(colorButton),
          ),
          onPressed: function != null ? () => function() : voidCallback,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: COLOR_TEXT),
          ),
        ),
      ),
    );
  }

  static Future<void> showAlertMensage({required String text, required BuildContext context}) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(width: 10),
            Icon(Icons.verified_user, color: Colors.green, size: 30),
          ],
        ),
      ),
    );
    await Future.delayed(Duration(seconds: 2)).then((value) => Navigator.pop(context));
  }
}
