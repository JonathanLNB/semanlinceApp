import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:semana_lince/TDA/Evento.dart';

class DetalleEvento extends StatelessWidget {
  Evento evento;

  DetalleEvento(this.evento);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/images/fondo.png"),
              fit: BoxFit.none,
              repeat: ImageRepeat.repeat),
        ),
      ),
      NavigationBar(false),
      Padding(
        padding: Platform.isAndroid
            ? EdgeInsets.only(left: 20, top: 40, right: 10)
            : EdgeInsets.only(left: 20, top: 50, right: 10),
        child: Text(
          "Semana Lince",
          style: TextStyle(
              color: AppColors.colorAccent,
              fontSize: 30.0,
              fontFamily: "GoogleSans",
              fontWeight: FontWeight.bold),
        ),
      )
    ]));
  }
}
