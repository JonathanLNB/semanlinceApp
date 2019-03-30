import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semana_lince/Categorias/mostrarCategoria.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:semana_lince/Principal/user_info.dart';
import 'package:semana_lince/Herramientas/lista_eventos.dart';
import 'package:semana_lince/TDA/Persona.dart';
import 'package:semana_lince/TDA/Sesion.dart';

class Principal extends StatelessWidget {
  List<Sesion> lista = [
    new Sesion(
        1,
        1,
        'El uso de las redes sociales y su efecto en las relaciones interpersonales',
        "27/05/2019",
        "10:45"),
    new Sesion(
        2,
        2,
        'Introducción a la Dinámica Molecular para Ing. Química y áreas afines.',
        "27/05/2019",
        "10:45"),
    new Sesion(3, 3, 'Hackaton', "27/05/2019", "10:45"),
    new Sesion(4, 4, 'PostgreSQL', "27/05/2019", "10:45"),
  ];
  bool datos = false;

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
        getPrincipal(context),
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
      ]),
    );
  }

  Widget getPrincipal(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
              children: <Widget>[
                UserInfo(new Persona(1, "Jonathan Leonardo Nieto Bustamante",
                    "Ingenieria en Sistemas Computacionales", "15030089")),
                datos
                    ? ListaEventos("Mis Actividades", lista)
                    : Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 60, bottom: 20),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/images/sad.png'),
                            )),
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 70),
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
            )
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
