class Persona {
  int idCarrera;
  String nombre;
  String carrera;
  String noControl;

  Persona(this.idCarrera, this.nombre, this.carrera, this.noControl);

  String getNombre() {
    return nombre;
  }

  String getCarrera() {
    return carrera;
  }

  String getNoControl() {
    return noControl;
  }

  int getIdCarrera() {
    return idCarrera;
  }
}
