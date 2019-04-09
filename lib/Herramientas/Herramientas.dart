import 'dart:math';

class Herramientas {
  static String getCategoria(int idCategoria) {
    switch (idCategoria) {
      case 1:
        return "Academica";

      case 2:
        return "Arte y Cultura";

      case 3:
        return "Deportivo";

      case 4:
        return "Desarrollo Profesional";

      case 5:
        return "Empresa";
    }
  }

  static String getTipoEvento(int idTipoE) {
    switch (idTipoE) {
      case 1:
        return "Taller";
      case 2:
        return "Conferencia";
      case 3:
        return "Curso";
      case 4:
        return "Visita";
      case 5:
        return "Actividad";
    }
  }

  static String getImagen(int idCategoria) {
    Random random = new Random();
    int aux;
    if (idCategoria == 2)
      aux = (random.nextInt(18) + 1);
    else
      aux = (random.nextInt(11) + 1);
    switch (idCategoria) {
      case 1:
        //Academica
        return "assets/images/Academica/$aux.jpg";

      case 2:
        //Arte y Cultura
        return "assets/images/Cultura/$aux.jpg";

      case 3:
        //Deportivo
        return "assets/images/Deportivo/$aux.jpg";

      case 4:
        //Desarrollo Profesional
        return "assets/images/Tecno/$aux.jpg";

      case 5:
        //Empresa
        return "assets/images/Empresas/$aux.jpg";

      default:
        return "assets/images/conferencia.jpg";
    }
  }

  static String getCarrera(int idCarrera) {
    switch (idCarrera) {
      case 0:
        return "Cargando...";
      case 1:
        return "Ingeniería Ambiental";
      case 2:
        return "Ingeniería Mecatrónica";
      case 3:
        return "Ingeniería Bioquímica";
      case 4:
        return "Ingeniería en Gestión Empresarial";
      case 5:
        return "Ingeniería en Electrónica";
      case 6:
        return "Ingeniería Industrial";
      case 7:
        return "Ingeniería Mecánica";
      case 8:
        return "Ingeniería Química";
      case 9:
        return "Ingeniería en Sistemas Computacionales";
      case 10:
        return "Ingeniería en Informática";
      case 11:
        return "Licenciatura en Administración";
      case 12:
        return "Maestría en Ciencias en Ingeniería Química";
      case 13:
        return "Maestría en Ciencias en Ingeniería Mecánica";
      case 14:
        return "Maestría en Ciencias en Ingeniería Bioquímica";
      case 15:
        return "Maestría en Gestión Administrativa";
      case 16:
        return "Maestría en Ciencias en Ingeniería Electrónica";
      case 17:
        return "Maestría en Ingeniería Industrial";
      case 18:
        return "Maestría en Ingeniería Química";
      case 19:
        return "Maestría en Innovación Aplicada";
      case 20:
        return "Intercambio";
      case 21:
        return "Neutral";
      case 22:
        return "Centro de información";
      case 23:
        return "Extra-Escolares";
      case 24:
        return "Ciencias Básicas";
      case 25:
        return "Vinculación";
      case 26:
        return "Desarrollo Académico";
      case 27:
        return "Extensión Apaseo";
      case 28:
        return "Servicio Externo";
    }
  }

  static String getFecha(int idFecha) {
    switch (idFecha) {
      case 1:
        return "07/05/2019";
      case 2:
        return "06/05/2019";
      case 3:
        return "08/05/2019";
    }
  }
}
