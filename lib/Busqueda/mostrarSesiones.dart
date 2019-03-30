import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semana_lince/Adaptadores/SesionAdapter.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:semana_lince/TDA/Sesion.dart';

class MostrarSesiones extends StatelessWidget {
  List<Sesion> lista = [
    new Sesion(
        0,
        1,
        'El uso de las redes sociales y su efecto en las relaciones interpersonales',
        "27/05/2019",
        "10:45"),
    new Sesion(
        0,
        1,
        'El uso de las redes sociales y su efecto en las relaciones interpersonales',
        "28/05/2019",
        "10:45"),
    new Sesion(
        0,
        1,
        'El uso de las redes sociales y su efecto en las relaciones interpersonales',
        "29/05/2019",
        "10:45"),
    new Sesion(
        0,
        1,
        'El uso de las redes sociales y su efecto en las relaciones interpersonales',
        "30/05/2019",
        "10:45"),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/images/fondo.png"),
                fit: BoxFit.none,
                repeat: ImageRepeat.repeat),
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.only(left: 10, top: 120),
          itemBuilder: (context, index) {
            Sesion aux = lista[index];
            return SesionAdapter(aux);
          },
          scrollDirection: Axis.vertical,
          itemCount: lista.length,
        ),
        NavigationBar(false),
        Padding(
          padding: Platform.isAndroid
              ? EdgeInsets.only(left: 20, top: 40, right: 10)
              : EdgeInsets.only(left: 20, top: 50, right: 10),
          child: Text(
            "Sesiones",
            style: TextStyle(
                color: AppColors.colorAccent,
                fontSize: 30.0,
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ));
  }
}
