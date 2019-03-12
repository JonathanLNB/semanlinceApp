import 'dart:io';

import 'package:flutter/material.dart';
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
              padding: EdgeInsets.only(top: 150),
              children: <Widget>[
                getBuscador(context),
                ListaCategorias("Academica"),
                ListaCategorias("Arte y Cultura"),
                ListaCategorias("Deportivo"),
                ListaCategorias("Desarrollo Profesional"),
                ListaCategorias("Empresa"),
              ],
            ),
            NavigationBar(true),
            Padding(
              padding: Platform.isAndroid
                  ? EdgeInsets.only(left: 20, top: 40, right: 10)
                  : EdgeInsets.only(left: 20, top: 50, right: 10),
              child: Text(
                "Categorias",
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54, blurRadius: 15.0, offset: Offset(0.0, 7.0))
        ],
      ),
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
          ),
          Icon(Icons.search,
            color: AppColors.verdeDarkLightColor,
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
          ),
          Text(
            "Buscar",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: "GoogleSans",
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: AppColors.verdeDarkLightColor
            ),
          )
        ],
      ),
    );
  }
}
