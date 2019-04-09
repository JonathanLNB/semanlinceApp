import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTest {
  Future<String> getNombre() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("nombre") ?? '';
  }

  Future<bool> setNombre(String nombre) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("nombre", nombre);
    return prefs.commit();
  }

  Future<String> getNoControl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("noControl") ?? '';
  }

  Future<bool> setNoControl(String nombre) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("noControl", nombre);
    return prefs.commit();
  }

  Future<int> getIdCarrera() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("idCarrera") ?? 0;
  }

  Future<bool> setIdCarrera(int carrera) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("idCarrera", carrera);
    return prefs.commit();
  }

  Future<int> getIdEncargado() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("idEncargado") ?? 0;
  }

  Future<bool> setIdEncargado(int encargado) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("idEncargado", encargado);
    return prefs.commit();
  }

  Future<int> getSemestre() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("semestre") ?? 0;
  }

  Future<bool> setSemestre(int semestre) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("semestre", semestre);
    return prefs.commit();
  }

  Future<String> getFoto() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("foto") ?? "";
  }

  Future<bool> setFoto(String foto) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("foto", foto);
    return prefs.commit();
  }
}
