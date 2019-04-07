import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTest {
  Future<String> getNombre() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("nombre") ?? 'name';
  }

  Future<bool> setNombre(String nombre) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString("nombre", nombre);
  }

  Future<String> getNoControl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("noControl") ?? '';
  }

  Future<bool> setNoControl(String nombre) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString("noControl", nombre);
  }

  Future<int> getIdCarrera() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("idCarrera") ?? 0;
  }

  Future<bool> setIdCarrera(int carrera) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt("idCarrera", carrera);
  }

  Future<int> getIdEncargado() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("idEncargado") ?? 0;
  }

  Future<bool> setIdEncargado(int encargado) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt("idEncargado", encargado);
  }

  Future<int> getSemestre() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("semestre") ?? 0;
  }

  Future<bool> setSemestre(int semestre) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt("semestre", semestre);
  }

  Future<String> getFoto() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("foto") ?? "";
  }

  Future<bool> setFoto(String foto) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString("foto", foto);
  }
}
