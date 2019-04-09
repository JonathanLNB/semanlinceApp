import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semana_lince/Adaptadores/SesionAdapter.dart';
import 'package:semana_lince/Herramientas/Progress.dart';
import 'package:semana_lince/Herramientas/SharedPreferences.dart';
import 'package:semana_lince/Herramientas/Strings.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:semana_lince/TDA/Espacio.dart';
import 'package:semana_lince/TDA/Evento.dart';
import 'package:semana_lince/TDA/Ponente.dart';
import 'package:semana_lince/TDA/Sesion.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MostrarSesiones extends StatefulWidget {
  int idEvento;

  MostrarSesiones(this.idEvento);

  State<StatefulWidget> createState() => new _MostrarSesiones(idEvento);
}

class _MostrarSesiones extends State<MostrarSesiones> {
  SharedPreferencesTest sharedPreferences = new SharedPreferencesTest();
  String noControl;

  List<Sesion> sesiones = [];
  int idEvento;

  _MostrarSesiones(this.idEvento);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSharedPreferences(context);
  }

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
        sesiones.length>0?
        Container(
          alignment: Alignment.center,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10, top: 120),
            itemBuilder: (context, index) {
              Sesion aux = sesiones[index];
              return SesionAdapter(aux);
            },
            scrollDirection: Axis.vertical,
            itemCount: sesiones.length,
          ),
        ):
        getSad(),
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

  _getSharedPreferences(BuildContext context) async {
    noControl = await sharedPreferences.getNoControl();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _onLoading(context));
    _Eventos(context);
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

  void _Eventos(BuildContext context) {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${Strings.usuario}:${Strings.contrasena}'));
    String server =
        "${Strings.server}api/movil/sesion/${idEvento}/${noControl}";
    print(server);
    Future<String> getData() async {
      http.Response response = await http.get(Uri.encodeFull(server), headers: {
        "content-type": "application/json",
        "accept": "application/json"
      });
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['valid'].toString() == '1') {
        _onSuccessWeb(data);
      }
    }

    getData();
  }

  _onSuccessWeb(data) async {
    Navigator.pop(context);
    List sesionesAux = data["sesiones"];
    List<Sesion> listaAux = [];
    if (sesionesAux != null) {
      for (int i = 0; i < sesionesAux.length; i++) {
        listaAux.add(
          new Sesion(
              sesionesAux[i]["idsesion"],
              new Evento.setSesion(
                  sesionesAux[i]["evento"],
                  sesionesAux[i]["material_alumno"],
                  sesionesAux[i]["descripcion"],
                  sesionesAux[i]["idcategoria"],
                  sesionesAux[i]["idtipoe"]),
              new Espacio(sesionesAux[i]["idespacio"],
                  sesionesAux[i]["espacio"], sesionesAux[i]["espaciodesc"], 0),
              new Ponente.sinEncargado(
                  sesionesAux[i]["idponente"],
                  sesionesAux[i]["ponente"],
                  sesionesAux[i]["biografia"],
                  sesionesAux[i]["imagen"]),
              sesionesAux[i]["idfecha"],
              sesionesAux[i]["horainicio"],
              sesionesAux[i]["horafinal"],
              false),
        );
        setState(() {
          sesiones = listaAux;
        });
      }
    }
  }

  Column getSad() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 200, bottom: 20),
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
                    "Este evento no tiene sesiones disponibles",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        color: AppColors.verdeDarkColor),
                    textAlign: TextAlign.center,
                  )),
            )),
      ],
    );
  }
}
