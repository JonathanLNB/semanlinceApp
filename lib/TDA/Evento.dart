import 'dart:math';

import 'package:semana_lince/TDA/Encargado.dart';

class Evento {
  int idEvento;
  String evento;
  String materialPonente;
  String materialAlumno;
  String descripcion;
  int capacidad;
  int idTipoE;
  int idServicio;
  int idCategoria;
  Encargado encargado;
  int aux;

  Evento();
  Evento.mas(this.idEvento, this.evento);
  Evento.setBasicos(this.idEvento, this.evento, this.idCategoria, this.encargado, this.idTipoE);
  Evento.setSesion(this.idEvento, this.evento, this.materialAlumno, this.descripcion, this.idCategoria, this.idTipoE);
  Evento.setTodo(this.idEvento, this.evento, this.materialAlumno, this.descripcion, this.idCategoria, this.encargado, this.idTipoE);

}
