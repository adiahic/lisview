import 'package:flutter/material.dart';
import 'package:lisview/main.dart';

var upute2;

class CoctailPage extends StatefulWidget {
  final List kokteli;
  final int index;
  final List slike;

  @override
  _CoctailPageState createState() => _CoctailPageState();

  CoctailPage(this.kokteli, this.index, this.slike);
}

class _CoctailPageState extends State<CoctailPage> {
  @override
  initState() {
    upute = Network2(widget.kokteli[widget.index]).koktel().then((value) {
      print(upute);
      upute2 = value;
      setState(() {
        print(upute2);
      });
    });
    print(upute2);
  }

  Widget build(BuildContext context) {
    print('build $upute');
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
                  '${widget.kokteli[widget.index]}',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 45.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(widget.slike[widget.index]),
                ),
                Text(
                  upute2,
                  style: TextStyle(
                    backgroundColor: Colors.white,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Text(
                //     'Napravite ovaj koktel i popijte ga, poslije ramazana',
                //    ),
              ],
            ))),
      ),
    );
  }
}
