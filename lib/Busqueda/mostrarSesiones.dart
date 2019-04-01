import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semana_lince/Adaptadores/SesionAdapter.dart';
import 'package:semana_lince/Herramientas/Strings.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:semana_lince/TDA/Espacio.dart';
import 'package:semana_lince/TDA/Evento.dart';
import 'package:semana_lince/TDA/Ponente.dart';
import 'package:semana_lince/TDA/Sesion.dart';

class MostrarSesiones extends StatelessWidget {
  List<Sesion> lista = [
    new Sesion(1, new Evento.setSesion(1, "Hackaton", "Libreta", "Descubriremos muchas cosas", 2, 3), new Espacio(1, "Centro para las artes", "Ubicado en campus 2", 10), new Ponente.sinEncargado(1, "Juan Patricio", "Inge egresado", "url"), 1,
        "10:30", "17:04"),
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
            Strings.sesion,
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
