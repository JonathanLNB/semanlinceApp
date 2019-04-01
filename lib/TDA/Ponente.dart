import 'package:semana_lince/TDA/Encargado.dart';

class Ponente {
  int idPonente;
  String ponente;
  String biografia;
  String imagen;
  Encargado encargado;

  Ponente(this.idPonente, this.ponente, this.biografia, this.imagen,
      this.encargado);
  Ponente.sinEncargado(this.idPonente, this.ponente, this.biografia, this.imagen);
}
