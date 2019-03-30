class Sesion {
  int idEvento;
  int idCategoria;
  String nombre;
  String fecha;
  String hora;

  Sesion(this.idEvento, this.idCategoria, this.nombre, this.fecha, this.hora);

  int getIdEvento() {
    return idEvento;
  }

  String getNombre() {
    return nombre;
  }

  String getImagen() {
    switch (idCategoria) {
      case 1:
        //Academica
        return "assets/images/conferencia.jpg";
        break;
      case 2:
        //Arte y Cultura
        return "assets/images/conferencia.jpg";
        break;
      case 3:
        //Deportivo
        return "assets/images/conferencia.jpg";
        break;
      case 4:
        //Desarrollo Profesional
        return "assets/images/conferencia.jpg";
        break;
      case 5:
        //Empresa
        return "assets/images/conferencia.jpg";
        break;
      default:
        //No definido
        return "assets/images/conferencia.jpg";
    }
  }
  String getFecha(){
    return fecha;
  }
  String getHora(){
    return hora;
  }
}
