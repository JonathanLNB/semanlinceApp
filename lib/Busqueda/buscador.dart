import 'package:flutter/material.dart';

class Buscador extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new BuscadorState();
}

class BuscadorState extends State<Buscador> {
  List<String> items;
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  initState() {
    items = new List<String>();
    items.add("Apple");
    items.add("Bananas");
    items.add("Milk");
    items.add("Water");
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      new Padding(
        padding: new EdgeInsets.only(top: 20.0),
      ),
      new TextField(
        decoration: new InputDecoration(labelText: "Search something"),
        controller: controller,
      ),
      new Expanded(
          child: new ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(child: new Text(items[index]));
        },
      ))
    ]);
  }
}
