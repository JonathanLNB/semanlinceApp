import 'package:flutter/material.dart';
import 'package:semana_lince/Busqueda/mostrarSesiones.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/TDA/Evento.dart';

class EventoAdapter extends StatefulWidget {
  Evento evento;

  EventoAdapter(this.evento);

  State<EventoAdapter> createState() => _EventoAdapter(evento);
}

class _EventoAdapter extends State<EventoAdapter>
    with AutomaticKeepAliveClientMixin {
  Evento evento;

  _EventoAdapter(this.evento);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => new MostrarSesiones()));
        },
        child: Stack(
          children: <Widget>[cardRight(context), cardLeft(context)],
        ));
  }

  Container cardLeft(BuildContext context) {
    return Container(
      height: 150.0,
      width: 250.0,
      margin: EdgeInsets.only(right: 40.0, left: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.transparent,
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54, blurRadius: 15.0, offset: Offset(0.0, 7.0))
        ],
      ),
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(8.0),
        child: Image.asset(
          evento.getImagen(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container cardRight(BuildContext context) {
    return Container(
      height: 80.0,
      width: 250,
      margin: EdgeInsets.only(top: 120.0, left: 50.0, right: 10.0),
      decoration: BoxDecoration(
        color: AppColors.verdeDarkLightColor,
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
          evento.getNombre(),
          textAlign: TextAlign.left,
          style: TextStyle(
              color: AppColors.colorAccent,
              fontSize: evento.getNombre().length > 40 ? 13.0 : 18.0,
              fontFamily: "GoogleSans"),
        ),
      )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
