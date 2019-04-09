import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semana_lince/Herramientas/Herramientas.dart';
import 'package:semana_lince/Herramientas/Progress.dart';
import 'package:semana_lince/Herramientas/SharedPreferences.dart';
import 'package:semana_lince/Herramientas/Strings.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:semana_lince/Principal/principal.dart';
import 'package:semana_lince/TDA/Sesion.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetalleSesion extends StatelessWidget {
  SharedPreferencesTest sharedPreferences = new SharedPreferencesTest();
  Sesion sesion;
  String nombre;
  String noControl;

  DetalleSesion(this.sesion);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _getSharedPreferences();
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
            onPressed: () {
              if (sesion.inscrito) {
                showDialog(
                    context: context,
                    builder: (_) => FlareGiffyDialog(
                          flarePath: 'assets/images/space_demo.flr',
                          flareAnimation: 'loading',
                          title: Text(
                            'Confirmación 😱',
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: "GoogleSans",
                                fontWeight: FontWeight.bold,
                                color: AppColors.verdeDarkLightColor),
                          ),
                          description: Text(
                            '¿${nombre.split(" ")[2]} estás segur@ de desinscribirte a esta actividad?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "GoogleSans",
                                color: AppColors.azulMarino),
                          ),
                          onOkButtonPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => _onLoading(context));
                            _Eliminar(context);
                          },
                        ));
              } else {
                showDialog(
                    context: context,
                    builder: (_) => FlareGiffyDialog(
                          flarePath: 'assets/images/space_demo.flr',
                          flareAnimation: 'loading',
                          title: Text(
                            'Confirmación 👌',
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: "GoogleSans",
                                fontWeight: FontWeight.bold,
                                color: AppColors.verdeDarkLightColor),
                          ),
                          description: Text(
                            '¿${nombre.split(" ")[2]} estás segur@ de inscribirte a esta actividad?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "GoogleSans",
                                color: AppColors.azulMarino),
                          ),
                          onOkButtonPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => _onLoading(context));
                            _Inscribir(context);
                          },
                        ));
              }
            },
            tooltip: sesion.inscrito ? 'Inscribirse' : 'Desinscribirse',
            child: sesion.inscrito
                ? new Image.asset(
                    "assets/images/cruzar.png",
                    width: 25,
                    height: 25,
                  )
                : new Image.asset(
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
                    textAlign: TextAlign.center,
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
                  child: Html(
                    data: sesion.evento.descripcion != null
                        ? sesion.evento.descripcion
                        : '',
                    defaultTextStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        color: AppColors.verdeDarkLightColor),
                  ),
                ),
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
                    textAlign: TextAlign.center,
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
                      textAlign: TextAlign.center,
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
                    textAlign: TextAlign.center,
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
                      textAlign: TextAlign.center,
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
                    textAlign: TextAlign.center,
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
                    child: Html(
                      data: sesion.evento.materialAlumno != null
                          ? sesion.evento.materialAlumno
                          : '',
                      defaultTextStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: "GoogleSans",
                          fontWeight: FontWeight.bold,
                          color: AppColors.verdeDarkLightColor),
                    ),
                  ))
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
                    textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
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
                    textAlign: TextAlign.center,
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
                      textAlign: TextAlign.center,
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
                    textAlign: TextAlign.center,
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
                      child: Html(
                        data: sesion.espacio.espacio,
                        defaultTextStyle: TextStyle(
                            fontSize: 15,
                            fontFamily: "GoogleSans",
                            fontWeight: FontWeight.bold,
                            color: AppColors.verdeDarkLightColor),
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
                    textAlign: TextAlign.center,
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
                    child: Html(
                      data: sesion.espacio.descripcion != null
                          ? sesion.espacio.descripcion
                          : '',
                      defaultTextStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: "GoogleSans",
                          fontWeight: FontWeight.bold,
                          color: AppColors.verdeDarkLightColor),
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
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Html(
                      data: sesion.ponente.biografia != null
                          ? sesion.ponente.biografia
                          : '',
                      defaultTextStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: "GoogleSans",
                          color: AppColors.grisObscuro),
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

  _getSharedPreferences() async {
    nombre = await sharedPreferences.getNombre();
    noControl = await sharedPreferences.getNoControl();
  }

  _onError(BuildContext context, String texto) {
    return Material(
        color: Colors.transparent,
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Container(
              width: 300,
              height: 280,
              margin: EdgeInsets.all(50),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      image: new AssetImage("assets/images/fondo.png"),
                      fit: BoxFit.none,
                      repeat: ImageRepeat.repeat),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 7.0))
                  ]),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/sad.png'),
                    )),
                  ),
                  Container(
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 5.0,
                        color: Colors.white,
                        child: Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Text(
                              texto,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "GoogleSans",
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.azulMarino),
                              textAlign: TextAlign.center,
                            )),
                      ))
                ],
              )),
          Align(
            alignment: Alignment.topRight,
            child: RaisedButton.icon(
                color: AppColors.azulMarino,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                label: Text('Cerrar')),
          )
        ]));
  }

  _onLoading(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ColorLoader3(
          radius: 20,
          dotRadius: 8,
        )
      ],
    );
  }

  void _Inscribir(BuildContext context) {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${Strings.usuario}:${Strings.contrasena}'));
    String server = "${Strings.server}api/movil/sesion/inscripcion";
    print(server);
    Future<String> getData() async {
      http.Response response = await http.post(Uri.encodeFull(server),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          },
          body: jsonEncode(
              {"idUsuario": noControl, "idSesion": sesion.idSesion}));
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['valid'].toString() == '1') {
        if (data['inscripcion'].toString() == '5') _onSuccessWeb(data, context);
        if (data['inscripcion'].toString() == '4')
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => _onError(
                  context, "Ya cuentas con el máximo de actividades  😰"));
        if (data['inscripcion'].toString() == '3')
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => _onError(
                  context, "Ya cuentas con el máximo de actividades 😰"));
        if (data['inscripcion'].toString() == '2')
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => _onError(context,
                  "Ya cuentas con el máximo de actidades de tu carrera 😰"));
        if (data['inscripcion'].toString() == '1')
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => _onError(
                  context, "Esta sesión se cruza con otra actividad 😰"));
      }
    }

    getData();
  }

  void _Eliminar(BuildContext context) {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${Strings.usuario}:${Strings.contrasena}'));
    String server =
        "${Strings.server}api/movil/sesion/inscripcion/${noControl}/${sesion.idSesion}";
    print(server);
    Future<String> getData() async {
      http.Response response = await http.delete(
        Uri.encodeFull(server),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        },
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['valid'].toString() == '1') {
        _onSuccessWeb(data, context);
      }
    }

    getData();
  }

  _onSuccessWeb(data, context) async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Principal()),
        ModalRoute.withName('/principal'));
  }
}
