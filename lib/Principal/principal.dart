import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semana_lince/Categorias/mostrarCategoria.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:semana_lince/Principal/user_info.dart';
import 'package:semana_lince/Herramientas/lista_eventos.dart';

class Principal extends StatelessWidget {
  bool datos = true;

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
        ),
        getPrincipal(context)
      ]),
    );
  }

  Widget getPrincipal(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            UserInfo(),
            datos
                ? ListaEventos("Mis Actividades")
                : Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 80, bottom: 10),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/sad.png'),
                        )),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 5.0,
                            color: Colors.white,
                            child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  "Aún no tienes actividades inscritas",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "GoogleSans",
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.verdeDarkColor),
                                  textAlign: TextAlign.left,
                                )),
                          )),
                    ],
                  ),
          ],
        ),
        new Padding(
          padding: const EdgeInsets.only(right: 15.0, bottom: 15.0),
          child: new Align(
            alignment: Alignment.bottomRight,
            child: new FloatingActionButton(
              backgroundColor: AppColors.verdeDarkColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MostrarCategoria()),
                );
              },
              tooltip: 'Buscar',
              child: new Icon(
                Icons.search,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
