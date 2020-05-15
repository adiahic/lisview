import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lisview/coctail_page.dart';

var kboja = Colors.yellow;
List<String> kokteli = [
  '',
];
List<String> slike = [
  '',
];

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new ListDisplay(),
    );
  }
}

class ListDisplay extends StatefulWidget {
  @override
  State createState() => new DyanmicList();
}

class DyanmicList extends State<ListDisplay> {
  final TextEditingController eCtrl = new TextEditingController();
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Obriši',
          child: Icon(Icons.cancel),
        ),
        appBar: new AppBar(
          title: new Text("Koktel demo po sastojku"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new TextField(
                  textAlign: TextAlign.center,
                  controller: eCtrl,
                  onSubmitted: (text) {
                    print(kokteli);
                    setState(
                      () {
                        vratiKoktel(text).then((onValue) {
                          setState(() {
                            //             kokteli.add(onValue);
                          });
                        });
                        slikaKoktel(text).then((onValue) {
                          setState(() {
                            //           slike.add(onValue);
                          });
                        });

                        eCtrl.clear();
                        setState(() {});
                      },
                    );
                  }),
              new Expanded(
                  child: StreamBuilder<Object>(
                      stream: null,
                      builder: (context, snapshot) {
                        return ListView.builder(
                            itemCount: kokteli.length,
                            itemBuilder: (BuildContext ctxt, int Index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  focusColor: Colors.blue,
                                  hoverColor: Colors.cyanAccent,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CoctailPage(
                                                kokteli, Index, slike)));
                                    setState(() {
                                      print(Index);
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: new Text(
                                          kokteli[Index],
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 25.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }))
            ],
          ),
        ));
  }

  void _incrementCounter() {
    setState(() {
      kokteli.clear();
      kokteli = [''];
      slike.clear();
      slike = [''];
    });
  }
}

class Network {
  var body;
  final String sastojak;

  Future<dynamic> koktel() async {
    var url =
        'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=$sastojak';
    http.Response response = await http.get(url);
    String data = response.body;

    if (response.statusCode == 200) {
      String data = response.body;

      var coct = jsonDecode(data);
      var coct1 = jsonDecode(data)['drinks'][0]['strDrink'];

      print(coct1);

      return coct;
    } else {
      print(response.statusCode);
    }
  }

  Network(this.sastojak);
}

Future<dynamic> vratiKoktel(text) async {
  var praviKoktel = await Network(text).koktel();
  var duzina = praviKoktel['drinks'].length - 1;
  int i;
  var pkoktel;

  for (i = 0; i < duzina; i++) {
    pkoktel = praviKoktel['drinks'][i]['strDrink'];

    kokteli.add(pkoktel);
  }
  return pkoktel;
}

Future<dynamic> slikaKoktel(text) async {
  var praviKoktel = await Network(text).koktel();
  int i;
  var pkoktel;
  var duzina = praviKoktel['drinks'].length - 1;

  for (i = 0; i < duzina; i++) {
    pkoktel = praviKoktel['drinks'][i]['strDrinkThumb'];

    slike.add(pkoktel);
  }
  return pkoktel;
}
