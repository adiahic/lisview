import 'package:flutter/material.dart';
import 'package:lisview/main.dart';

class CoctailPage extends StatelessWidget {
  final List kokteli;
  final int index;
  final List slike;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey,
        child: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${kokteli[index]}',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 45.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Image.network(slike[index]),
              ],
            ))),
      ),
    );
  }

  CoctailPage(this.kokteli, this.index, this.slike);
}
