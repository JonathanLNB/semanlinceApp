import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semana_lince/Adaptadores/EventoAdapter.dart';
import 'package:semana_lince/Herramientas/Strings.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Herramientas/lista_categorias.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:semana_lince/TDA/Evento.dart';

class MostrarEventos extends StatefulWidget {
  List<Evento> lista;
  MostrarEventos(this.lista);
  State<StatefulWidget> createState() => new _Buscador(lista);
}

class _Buscador extends State<MostrarEventos> {
  List<Evento> lista;
  TextEditingController controller = new TextEditingController();
  String filter;

  _Buscador(this.lista);

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
        new ListView.builder(
          padding: EdgeInsets.only(left: 30, top: 220),
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index) {
            Evento evento = lista[index];
            return filter == null || filter == ""
                ? new Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: EventoAdapter(evento),
                  )
                : evento.evento.toLowerCase().contains(filter.toLowerCase())
                    ? Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: EventoAdapter(evento),
                      )
                    : new Container();
          },
        ),
        getBuscador(context),
        NavigationBar(false),
        Padding(
            padding: Platform.isAndroid
                ? EdgeInsets.only(left: 20, top: 40, right: 10)
                : EdgeInsets.only(left: 20, top: 50, right: 10),
            child: Text(
              Strings.buscador,
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
}
