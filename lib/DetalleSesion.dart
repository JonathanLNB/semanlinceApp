import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semana_lince/Herramientas/Herramientas.dart';
import 'package:semana_lince/Herramientas/Strings.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:semana_lince/TDA/Sesion.dart';

class DetalleSesion extends StatelessWidget {
  Sesion sesion;

  DetalleSesion(this.sesion);

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
      ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 120),
          children: <Widget>[
            headerInfo(context),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            ),
            getTitulo(context),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            ),
            getMaterialAlumno(context),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            ),
            getLugar(context),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            ),
            getDescripcionLugar(context),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            ),
            getFecha(context),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            ),
            getHoras(context),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            ),
            getCategoria(context),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            ),
            getTipoE(context),
          ]),
      new Padding(
        padding: const EdgeInsets.only(right: 15.0, top: 85.0),
        child: new Align(
          alignment: Alignment.topRight,
          child: new FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {},
            tooltip: 'Inscribirse',
            child: new Image.asset(
              "assets/images/marca.png",
              width: 25,
              height: 25,
            ),
          ),
        ),
      ),
      NavigationBar(false),
      Padding(
        padding: Platform.isAndroid
            ? EdgeInsets.only(left: 20, top: 40, right: 10)
            : EdgeInsets.only(left: 20, top: 50, right: 10),
        child: Text(
          Strings.detalles,
          style: TextStyle(
              color: AppColors.colorAccent,
              fontSize: 30.0,
              fontFamily: "GoogleSans",
              fontWeight: FontWeight.bold),
        ),
      )
    ]));
  }

  Container getTitulo(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5.0,
          color: AppColors.verdeDarkLightColor,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    sesion.evento.evento,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  )),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                elevation: 15.0,
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: Text(
                      sesion.evento.descripcion,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "GoogleSans",
                          fontWeight: FontWeight.bold,
                          color: AppColors.verdeDarkLightColor),
                      textAlign: TextAlign.center,
                    )),
              )
            ],
          ),
        ));
  }

  Container getTipoE(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5.0,
          color: AppColors.verdeDarkLightColor,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    Strings.tipoE,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  )),
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                elevation: 5.0,
                color: Colors.white,
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: Text(
                      Herramientas.getTipoEvento(sesion.evento.idTipoE),
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "GoogleSans",
                          fontWeight: FontWeight.bold,
                          color: AppColors.verdeDarkLightColor),
                      textAlign: TextAlign.left,
                    )),
              )
            ],
          ),
        ));
  }

  Container getCategoria(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5.0,
          color: AppColors.verdeDarkLightColor,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    Strings.categorias,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  )),
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                elevation: 5.0,
                color: Colors.white,
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: Text(
                      Herramientas.getCategoria(sesion.evento.idCategoria),
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "GoogleSans",
                          fontWeight: FontWeight.bold,
                          color: AppColors.verdeDarkLightColor),
                      textAlign: TextAlign.left,
                    )),
              )
            ],
          ),
        ));
  }

  Container getMaterialAlumno(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5.0,
          color: AppColors.verdeDarkLightColor,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    Strings.materialAlumno,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  )),
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                elevation: 5.0,
                color: Colors.white,
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: Text(
                      sesion.evento.materialAlumno,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "GoogleSans",
                          fontWeight: FontWeight.bold,
                          color: AppColors.verdeDarkLightColor),
                      textAlign: TextAlign.left,
                    )),
              )
            ],
          ),
        ));
  }

  Container getFecha(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5.0,
          color: AppColors.verdeDarkLightColor,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    Strings.fecha,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  )),
              Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  elevation: 5.0,
                  color: Colors.white,
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      child: Text(
                        Herramientas.getFecha(sesion.idFecha),
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "GoogleSans",
                            fontWeight: FontWeight.bold,
                            color: AppColors.verdeDarkLightColor),
                        textAlign: TextAlign.left,
                      )))
            ],
          ),
        ));
  }

  Container getHoras(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5.0,
          color: AppColors.verdeDarkLightColor,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    Strings.duracion,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  )),
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                elevation: 5.0,
                color: Colors.white,
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: Text(
                      sesion.horaInicio + " - " + sesion.horaFin,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "GoogleSans",
                          fontWeight: FontWeight.bold,
                          color: AppColors.verdeDarkLightColor),
                      textAlign: TextAlign.left,
                    )),
              )
            ],
          ),
        ));
  }

  Container getLugar(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5.0,
          color: AppColors.verdeDarkLightColor,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    Strings.lugar,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  )),
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                elevation: 5.0,
                color: Colors.white,
                child: Container(
                    margin: EdgeInsets.all(10),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        sesion.espacio.espacio,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "GoogleSans",
                            fontWeight: FontWeight.bold,
                            color: AppColors.verdeDarkLightColor),
                        textAlign: TextAlign.center,
                      ),
                    )),
              )
            ],
          ),
        ));
  }

  Container getDescripcionLugar(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5.0,
          color: AppColors.verdeDarkLightColor,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                    Strings.descripcionLugar,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  )),
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                elevation: 5.0,
                color: Colors.white,
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    child: Text(
                      sesion.espacio.descripcion,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "GoogleSans",
                          fontWeight: FontWeight.bold,
                          color: AppColors.verdeDarkLightColor),
                      textAlign: TextAlign.left,
                    )),
              )
            ],
          ),
        ));
  }

  Container headerInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                    width: 250,
                  ),
                  Text(
                    sesion.ponente.ponente,
                    style: TextStyle(
                      color: AppColors.verdeColor,
                      fontSize: 20.0,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    sesion.ponente.biografia,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grisObscuro,
                      fontSize: 15.0,
                      fontFamily: "GoogleSans",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
