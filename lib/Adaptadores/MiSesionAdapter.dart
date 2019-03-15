import 'package:flutter/material.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/TDA/Evento.dart';
import 'package:semana_lince/TDA/Sesion.dart';

class MiSesionAdapter extends StatelessWidget {
  Sesion sesion;

  MiSesionAdapter(this.sesion);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
        alignment: Alignment(0.9, 1.15),
        children: <Widget>[card(context), gradiente(context), titulo(context)]);
  }

  Container card(BuildContext context) {
    return Container(
      height: 350.0,
      width: 250.0,
      margin: EdgeInsets.only(
        left: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(fit: BoxFit.cover, image: AssetImage(sesion.getImagen())),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54, blurRadius: 15.0, offset: Offset(0.0, 7.0))
        ],
      ),
    );
  }

  Container gradiente(BuildContext context) {
    return Container(
      height: 350.0,
      width: 250.0,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            shape: BoxShape.rectangle,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.5],
                colors: [Color(0x00FFFFFF), Color(0xAA000000)])),
      ),
    );
  }

  Container titulo(BuildContext context) {
    return Container(
      height: 350.0,
      width: 250.0,
      child: Text(
        sesion.getNombre(),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontFamily: "GoogleSans",
            fontWeight: FontWeight.bold),
      ),
      alignment: Alignment.center,
    );
  }
}
