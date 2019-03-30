import 'dart:math';

class Evento {
  Random random = new Random();
  int idEvento;
  int idCategoria;
  String nombre;
  int aux;

  Evento(this.idEvento, this.idCategoria, this.nombre);

  generarRandom() {
    if (idCategoria == 1 || idCategoria == 3)
      aux = (random.nextInt(11) + 1);
    else if (idCategoria == 2)
      aux = (random.nextInt(12) + 1);
    else
      aux = (random.nextInt(11) + 1);
  }

  getIdEvento() {
    return idEvento;
  }

  getNombre() {
    return nombre;
  }

  getImagen() {
    switch (idCategoria) {
      case 1:
        //Academica
        return "assets/images/Tecno/$aux.jpg";
        break;
      case 2:
        //Arte y Cultura
        return "assets/images/Cultura/$aux.jpg";
        break;
      case 3:
        //Deportivo
        return "assets/images/Deportivo/$aux.jpg";
        break;
      case 4:
        //Desarrollo Profesional
        return "assets/images/Deportivo/$aux.jpg";
        break;
      case 5:
        //Empresa
        // return "assets/images/Cultura/$aux.jpg";
        return "assets/images/conferencia.jpg";
        break;
      default:
        //No definido
        return "assets/images/Cultura/$aux.jpg";
        return "assets/images/conferencia.jpg";
    }
  }
}
