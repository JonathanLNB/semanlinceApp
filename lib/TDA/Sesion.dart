import 'dart:math';

import 'package:semana_lince/TDA/Espacio.dart';
import 'package:semana_lince/TDA/Evento.dart';
import 'package:semana_lince/TDA/Ponente.dart';
import 'package:semana_lince/TDA/ProfeStaff.dart';

class Sesion {
  int idSesion;
  Evento evento;
  Espacio espacio;
  Ponente ponente;
  ProfeStaff staff;
  int idFecha;
  String horaInicio;
  String horaFin;
  bool inscrito;
  Sesion(this.idSesion, this.evento, this.espacio, this.ponente, this.idFecha, this.horaInicio, this.horaFin, this.inscrito);

}
