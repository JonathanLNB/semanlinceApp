import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semana_lince/Busqueda/mostrarEventos.dart';
import 'package:semana_lince/Herramientas/Progress.dart';
import 'package:semana_lince/Herramientas/SharedPreferences.dart';
import 'package:semana_lince/Herramientas/Strings.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Herramientas/lista_categorias.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'package:semana_lince/TDA/Evento.dart';

class MostrarCategoria extends StatelessWidget {
  String noControl = "";
  String noControlAux = "";
  int idCategoria = 0;
  SharedPreferencesTest sharedPreferences = new SharedPreferencesTest();

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
            ListaCategorias("Académica", 1),
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
          _getSharedPreferences(context);
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

  _getSharedPreferences(BuildContext context) async {
    noControlAux = await sharedPreferences.getNoControl();
    noControl = noControlAux;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _onLoading(context));
    _Eventos(context);
  }

  void _Eventos(BuildContext context) {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${Strings.usuario}:${Strings.contrasena}'));
    String server = "${Strings.server}api/movil/eventos/all/${noControl}";
    Future<String> getData() async {
      try {
        http.Response response = await http.get(Uri.encodeFull(server),
            headers: {
              "content-type": "application/json",
              "accept": "application/json"
            });
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data['valid'].toString() == '1') {
          _onSuccessWeb(data, context);
        }
      } catch (e) {
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Ocurrió un error, inténtalo más tarde 😰",
                style: TextStyle(fontFamily: "GoogleSans"))));
      }
    }

    getData();
  }

  void _onSuccessWeb(data, BuildContext context) {
    Navigator.pop(context);
    List lista = data["eventos"];
    List<Evento> eventosAux = [];
    if (lista != null) {
      for (int i = 0; i < lista.length; i++) {
        eventosAux.add(new Evento.setBasicos(
            lista[i]["idevento"],
            lista[i]["evento"],
            lista[i]["material_alumno"],
            lista[i]["descripcion"],
            lista[i]["idcategoria"],
            lista[i]["idtipoe"]));
      }
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => new MostrarEventos(eventosAux, 0)));
  }
}
