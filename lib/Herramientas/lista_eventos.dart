import 'package:flutter/material.dart';
import 'package:semana_lince/Adaptadores/evento.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/detalles.dart';

class ListaEventos extends StatelessWidget {
  String titulo = "Mis Actividades";

  ListaEventos(this.titulo);

  List<String> lista = ['FL Studio', 'Danza', 'Hackaton', 'PostgreSQL'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[getTitulo(context), getLista(context)],
      ),
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

  Container getLista(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        itemBuilder: (context, index) {
          String nombre = lista[index];
          return Evento(nombre);
        },
        padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 25.0, bottom: 25.0),
        scrollDirection: Axis.horizontal,
        itemCount: lista.length,
      ),
    );
  }
}
