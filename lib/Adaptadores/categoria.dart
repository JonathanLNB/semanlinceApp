import 'package:flutter/material.dart';
import 'package:semana_lince/Herramientas/appColors.dart';

class Categoria extends StatelessWidget {
  String nombre = "";
  String imagen = "";

  Categoria(this.nombre, this.imagen);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        cardRight(context),
        cardLeft(context)
      ],
    );
  }

  Container cardLeft(BuildContext context) {
    return Container(
      height: 150.0,
      width: 250.0,
      margin: EdgeInsets.only(
        right: 40.0,
        left: 10.0
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(fit: BoxFit.cover, image: AssetImage(imagen)),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54, blurRadius: 15.0, offset: Offset(0.0, 7.0))
        ],
      ),
    );
  }

  Container cardRight(BuildContext context) {
    return Container(
      height: 100.0,
      width: 250,
      margin: EdgeInsets.only(
        top: 120.0,
        left: 50.0,
        right: 10.0
      ),
      decoration: BoxDecoration(
        color: AppColors.azulMarino,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54, blurRadius: 15.0, offset: Offset(0.0, 7.0))
        ],
      ),
      child: (Container(
        margin: EdgeInsets.only(left: 5, top: 40, right: 5),
        child: Text(
          nombre,
          textAlign: TextAlign.left,
          style: TextStyle(
              color: AppColors.colorAccent,
              fontSize: nombre.length>40?13.0:18.0,
              fontFamily: "GoogleSans"),
        ),
      )),
    );
  }
}
