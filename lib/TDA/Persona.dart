import 'package:semana_lince/TDA/Encargado.dart';

class Persona {
  String idUsuario;
  String nombre;
  String foto;
  int semestre;
  int idCarrera;
  Encargado encargado;

  Persona(this.idCarrera, this.nombre, this.foto, this.idUsuario, this.semestre, this.encargado);

}
