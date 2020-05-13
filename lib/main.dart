import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<dynamic> zemlje = ['Bosna', 'Austrija', 'USA', 'Kuba', 'Malezija'];

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new ListDisplay(),
    );
  }
}

class ListDisplay extends StatefulWidget {
  @override
  State createState() => new DyanmicList();
}

class DyanmicList extends State<ListDisplay> {
  List<String> zemlje = [];
  final TextEditingController eCtrl = new TextEditingController();
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Dynamic Demo"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              new TextField(
                  controller: eCtrl,
                  onSubmitted: (text) {
                    setState(
                      () {
                        Network(text).koktel().then((onValue) {
                          setState(() {
                            zemlje.add(onValue);
                          });
                          //
                        });
//then((val) => setState(() {
                        //  zemlje.add(text);
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
                            itemCount: zemlje.length,
                            itemBuilder: (BuildContext ctxt, int Index) {
                              return new Text(
                                zemlje[Index],
                                style: TextStyle(fontSize: 25.0),
                              );
                            });
                      }))
            ],
          ),
        ));
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

      var coct = jsonDecode(data)['drinks'][0]['strDrink'];
      // zemlje.add(coct);
      print(coct);
      return coct;
    } else {
      print(response.statusCode);
    }
  }

  Network(this.sastojak);
}
