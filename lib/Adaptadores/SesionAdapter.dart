import 'package:flutter/material.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/TDA/Sesion.dart';

class SesionAdapter extends StatelessWidget {
  Sesion sesion;

  SesionAdapter(this.sesion);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Stack(
        children: <Widget>[
          cardFecha(context),
          card(context),
          gradiente(context),
          cardTexto(context),
        ],
      ),
    );
  }

  Container gradiente(BuildContext context) {
    return Container(
      height: 150.0,
      width: 300.0,
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
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

  Container card(BuildContext context) {
    return Container(
      height: 150.0,
      width: 300.0,
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage(sesion.getImagen())),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54, blurRadius: 15.0, offset: Offset(0.0, 7.0))
        ],
      ),
    );
  }

  Container cardTexto(BuildContext context) {
    return Container(
      height: 150.0,
      width: 300.0,
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Text(
        sesion.getNombre(),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.colorAccent,
            fontSize: sesion.getNombre().length > 40 ? 20.0 : 25.0,
            fontFamily: "GoogleSans"),
      ),
      alignment: Alignment.center,
    );
  }

  Container cardFecha(BuildContext context) {
    return Container(
      height: 130.0,
      width: 150.0,
      margin: EdgeInsets.only(top: 105, left: 95.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54, blurRadius: 15.0, offset: Offset(0.0, 7.0))
        ],
      ),
      child: (Container(
          margin: EdgeInsets.only(left: 5, top: 40, right: 5),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/calendario.png")),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/reloj.png")),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 2),
                  ),
                  Text(
                    sesion.getFecha(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.verdeDarkColor,
                        fontSize: sesion.getNombre().length > 40 ? 13.0 : 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "GoogleSans"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                  ),
                  Text(
                    sesion.getHora(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.verdeDarkColor,
                        fontSize: sesion.getNombre().length > 40 ? 13.0 : 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "GoogleSans"),
                  )
                ],
              )
            ],
          ))),
    );
  }
}
