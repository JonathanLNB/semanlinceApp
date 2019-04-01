import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semana_lince/Busqueda/mostrarEventos.dart';
import 'package:semana_lince/Herramientas/Strings.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Herramientas/lista_categorias.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';

class MostrarCategoria extends StatelessWidget {
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
        ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 120),
          children: <Widget>[
            getBuscador(context),
            ListaCategorias("Academica", 1),
            ListaCategorias("Arte y Cultura", 2),
            ListaCategorias("Deportivo", 3),
            ListaCategorias("Desarrollo Profesional", 4),
            ListaCategorias("Empresa", 5),
          ],
        ),
        NavigationBar(false),
        Padding(
          padding: Platform.isAndroid
              ? EdgeInsets.only(left: 20, top: 40, right: 10)
              : EdgeInsets.only(left: 20, top: 50, right: 10),
          child: Text(
            Strings.categorias,
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

  Widget getBuscador(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => new MostrarEventos(0)));
        },
        child: Padding(
            padding: EdgeInsets.only(right: 40, bottom: 30, top: 10),
            child: Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Material(
                    elevation: 10,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(0),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 40, right: 20, top: 10, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 20, bottom: 20),
                          ),
                          Icon(
                            Icons.search,
                            color: AppColors.verdeDarkLightColor,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                          ),
                          Text(
                            "Buscar",
                            style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: "GoogleSans",
                                color: AppColors.verdeDarkLightColor),
                          )
                        ],
                      ),
                    )))));
  }
}
