import 'package:flutter/material.dart';
import 'package:semana_lince/Adaptadores/categoria.dart';
import 'package:semana_lince/Herramientas/appColors.dart';

class ListaCategorias extends StatelessWidget {
  String titulo = "Mis Actividades";

  ListaCategorias(this.titulo);

  List<String> lista = ['El uso de las redes sociales y su efecto en las relaciones interpersonales', 'Introducción a la Dinámica Molecular para Ing. Química y áreas afines.', 'Hackaton', 'Uso de Caldera', 'Más'];

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

  Container getMas(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.center,
        child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 5.0,
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 55),
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
            )));
  }

  Container getLista(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        itemBuilder: (context, index) {
          String nombre = lista[index];
          if (nombre == 'Más')
            return getMas(context);
          else
            return Categoria(nombre, "assets/images/conferencia.jpg");
        },
        padding:
            EdgeInsets.only(top: 25.0, left: 20.0, right: 25.0, bottom: 25.0),
        scrollDirection: Axis.horizontal,
        itemCount: lista.length,
      ),
    );
  }
}
