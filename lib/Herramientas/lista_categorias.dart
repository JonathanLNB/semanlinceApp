import 'package:flutter/material.dart';
import 'package:semana_lince/Adaptadores/EventoAdapter.dart';
import 'package:semana_lince/Busqueda/mostrarEventos.dart';
import 'package:semana_lince/Herramientas/Progress.dart';
import 'package:semana_lince/Herramientas/SharedPreferences.dart';
import 'package:semana_lince/Herramientas/Strings.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/TDA/Evento.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListaCategorias extends StatefulWidget {
  String titulo = "Mis Actividades";
  int idCategoria = 0;

  ListaCategorias(this.titulo, this.idCategoria);

  State<StatefulWidget> createState() =>
      new _ListaCategorias(titulo, idCategoria);
}

class _ListaCategorias extends State<ListaCategorias> {
  String titulo = "Mis Actividades";
  String noControl = "";
  String noControlAux = "";
  int idCategoria = 0;
  SharedPreferencesTest sharedPreferences = new SharedPreferencesTest();

  _ListaCategorias(this.titulo, this.idCategoria);

  List<Evento> eventos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          getTitulo(context),
          eventos.length > 0 ? getLista(context) : getSad()
        ],
      ),
    );
  }

  Column getSad() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 60, bottom: 20),
          width: 60,
          height: 60,
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
                    "Esta categoría no tiene actividades",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "GoogleSans",
                        fontWeight: FontWeight.bold,
                        color: AppColors.verdeDarkColor),
                    textAlign: TextAlign.left,
                  )),
            )),
      ],
    );
  }

  Container getTitulo(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5.0,
          color: Colors.white,
          child: Container(
              margin: EdgeInsets.all(10),
              child: Text(
                titulo,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "GoogleSans",
                    fontWeight: FontWeight.bold,
                    color: AppColors.verdeDarkLightColor),
                textAlign: TextAlign.left,
              )),
        ));
  }

  GestureDetector getMas(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new MostrarEventos(eventos)));
        },
        child: Container(
            margin: EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 5.0,
                color: Colors.white,
                child: Container(
                  margin:
                      EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 55),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/flecha.png")),
                        ),
                      ),
                      Text(
                        "Ver más",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "GoogleSans",
                            fontWeight: FontWeight.bold,
                            color: AppColors.verdeDarkLightColor),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ))));
  }

  Container getLista(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        itemBuilder: (context, index) {
          Evento aux = eventos[index];
          if (index == 4)
            return getMas(context);
          else
            return new EventoAdapter(aux);
        },
        padding:
            EdgeInsets.only(top: 25.0, left: 20.0, right: 25.0, bottom: 25.0),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        addAutomaticKeepAlives: true,
      ),
    );
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

  _getSharedPreferences() async {
    noControlAux = await sharedPreferences.getNoControl();
    setState(() {
      noControl = noControlAux;
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _onLoading(context));
    _Eventos();
  }

  void _Eventos() {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${Strings.usuario}:${Strings.contrasena}'));
    String server =
        "${Strings.server}api/movil/eventos/${noControl}/${idCategoria}";
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
    setState(() {
      eventos = eventosAux;
    });
  }
}
