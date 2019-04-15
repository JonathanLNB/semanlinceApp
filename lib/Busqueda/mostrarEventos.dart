import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semana_lince/Adaptadores/EventoAdapter.dart';
import 'package:semana_lince/Herramientas/Herramientas.dart';
import 'package:semana_lince/Herramientas/Strings.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Herramientas/lista_categorias.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:semana_lince/TDA/Evento.dart';

class MostrarEventos extends StatefulWidget {
  List<Evento> lista;
  int idCategoria;

  MostrarEventos(this.lista, this.idCategoria);

  State<StatefulWidget> createState() => new _Buscador(lista, idCategoria);
}

class _Buscador extends State<MostrarEventos> {
  List<Evento> lista;
  TextEditingController controller = new TextEditingController();
  String filter;
  int idCategoria;
  
  _Buscador(this.lista, this.idCategoria);

  @override
  initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
        lista!=null
            ? new ListView.builder(
                padding: EdgeInsets.only(left: 30, top: 220),
                itemCount: lista.length,
                itemBuilder: (BuildContext context, int index) {
                  Evento evento = lista[index];
                  return filter == null || filter == ""
                      ? new Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: EventoAdapter(evento),
                        )
                      : evento.evento
                              .toLowerCase()
                              .contains(filter.toLowerCase())
                          ? Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: EventoAdapter(evento),
                            )
                          : new Container();
                },
              )
            : getSad(),
        getBuscador(context),
        NavigationBar(false),
        Padding(
            padding: Platform.isAndroid
                ? EdgeInsets.only(left: 20, top: 40, right: 10)
                : EdgeInsets.only(left: 20, top: 50, right: 10),
            child: Text(
              Herramientas.getCategoria(idCategoria),
              style: TextStyle(
                  color: AppColors.colorAccent,
                  fontSize: 30.0,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.bold),
            )),
      ],
    ));
  }

  Widget getBuscador(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40, bottom: 30, top: 130),
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
            padding: EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
            child: TextField(
              textInputAction: TextInputAction.search,
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: AppColors.verdeDarkLightColor,
                  ),
                  hintText: "Buscar",
                  hintStyle: TextStyle(
                      fontFamily: "GoogleSans",
                      color: AppColors.verdeDarkLightColor,
                      fontSize: 17)),
            ),
          ),
        ),
      ),
    );
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
