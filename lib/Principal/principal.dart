import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:semana_lince/Categorias/mostrarCategoria.dart';
import 'package:semana_lince/Herramientas/Progress.dart';
import 'package:semana_lince/Herramientas/SharedPreferences.dart';
import 'package:semana_lince/Herramientas/Strings.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:semana_lince/Principal/user_info.dart';
import 'package:semana_lince/Herramientas/lista_eventos.dart';
import 'package:semana_lince/SignIn.dart';
import 'package:semana_lince/TDA/Encargado.dart';
import 'package:semana_lince/TDA/Espacio.dart';
import 'package:semana_lince/TDA/Evento.dart';
import 'package:semana_lince/TDA/Persona.dart';
import 'package:semana_lince/TDA/Ponente.dart';
import 'package:semana_lince/TDA/Sesion.dart';

class Principal extends StatefulWidget {
  State<StatefulWidget> createState() => new _Principal();
}

class _Principal extends State<Principal> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  SharedPreferencesTest sharedPreferences = new SharedPreferencesTest();
  List<Sesion> lista = [];
  String nombre = "";
  String noControl = "";
  String foto = "";
  int idCarrera = 0;
  int idEncargado = 1;
  int semestre = 0;
  String nombreAux = "";
  String noControlAux = "";
  String fotoAux = "";
  int idCarreraAux = 0;
  int idEncargadoAux = 0;
  int semestreAux = 0;

  @override
  Future initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignIn()),
            ModalRoute.withName('/signIn'));
      }
    });
    _cargar();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/images/fondo.png"),
                fit: BoxFit.none,
                repeat: ImageRepeat.repeat),
          ),
        ),
        getPrincipal(context),
        NavigationBar(false),
        Padding(
          padding: Platform.isAndroid
              ? EdgeInsets.only(left: 20, top: 40, right: 10)
              : EdgeInsets.only(left: 20, top: 50, right: 10),
          child: Text(
            Strings.semanalince,
            style: TextStyle(
                color: AppColors.colorAccent,
                fontSize: 30.0,
                fontFamily: "GoogleSans",
                fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }

  Widget getPrincipal(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
              children: <Widget>[
                UserInfoM(new Persona(
                    idCarrera,
                    nombre,
                    foto,
                    noControl,
                    semestre,
                    new Encargado(idEncargado, "No Asignado", "", "", 9))),
                lista.length > 0
                    ? ListaEventos("Mis Actividades", lista)
                    : getSad(),
              ],
            )
          ],
        ),
        new Padding(
          padding: const EdgeInsets.only(right: 15.0, bottom: 15.0),
          child: new Align(
            alignment: Alignment.bottomRight,
            child: new FloatingActionButton(
              backgroundColor: AppColors.verdeDarkLightColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MostrarCategoria()),
                );
              },
              tooltip: 'Buscar',
              child: new Icon(
                Icons.add,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector getSad() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MostrarCategoria()));
      },
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 60, bottom: 20),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/sad.png'),
            )),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 70),
              alignment: Alignment.center,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 5.0,
                color: Colors.white,
                child: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Aún no tienes actividades inscritas",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "GoogleSans",
                          fontWeight: FontWeight.bold,
                          color: AppColors.verdeDarkColor),
                      textAlign: TextAlign.center,
                    )),
              )),
        ],
      ),
    );
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  _onLoading(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ColorLoader3(
          radius: 20,
          dotRadius: 8,
        )
      ],
    );
  }

  void cerrarSesion() async {
    _googleSignIn.signOut();
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
        ModalRoute.withName('/signIn'));
  }

  _getSharedPreferences() async {
    idCarreraAux = await sharedPreferences.getIdCarrera();
    nombreAux = await sharedPreferences.getNombre();
    fotoAux = await sharedPreferences.getFoto();
    noControlAux = await sharedPreferences.getNoControl();
    semestreAux = await sharedPreferences.getSemestre();
    idEncargadoAux = await sharedPreferences.getIdEncargado();
    setState(() {
      if (idCarreraAux > 0) idCarrera = idCarreraAux;
      if (nombreAux.length > 0)
        nombre = nombreAux;
      else {
        getUser().then((user) {
          if (user != null) {
            nombre = user.displayName;
          }
        });
      }
      if (fotoAux.length > 0)
        foto = fotoAux;
      else {
        getUser().then((user) {
          if (user != null) {
            foto = user.photoUrl;
          }
        });
      }
      if (noControlAux.length > 0) {
        noControl = noControlAux;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => _onLoading(context));
        _MisActividades();
      } else {
        getUser().then((user) {
          if (user != null) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => _onLoading(context));
            consumirDatos(user.email.split("@")[0]);
          }
        });
      }
      semestre = semestreAux;
      idEncargado = idEncargadoAux;
    });
  }

  void _MisActividades() {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${Strings.usuario}:${Strings.contrasena}'));
    String server = "${Strings.server}api/movil/sesion/${noControl}";
    Future<String> getData() async {
      try {
        http.Response response = await http.get(Uri.encodeFull(server),
            headers: {
              "content-type": "application/json",
              "accept": "application/json"
            });
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data['valid'].toString() == '1') {
          _onSuccessWeb(data);
        }
      } catch (e) {
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Ocurrió un error, inténtalo más tarde 😰",
                style: TextStyle(fontFamily: "GoogleSans"))));
      }
    }

    getData();
  }

  void _Configuracion() {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${Strings.usuario}:${Strings.contrasena}'));
    String server = "${Strings.server}api/configuracion";
    Future<String> getData() async {
      try {
        http.Response response = await http.get(Uri.encodeFull(server),
            headers: {
              "content-type": "application/json",
              "accept": "application/json"
            });
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data['valid'].toString() == '1') {
          _onSuccessConfig(data);
        }
      } catch (e) {
        Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Ocurrió un error, inténtalo más tarde 😰",
                style: TextStyle(fontFamily: "GoogleSans"))));
      }
    }

    getData();
  }

  _onSuccessConfig(data) async {
    setState(() {
      sharedPreferences.setInscribir(data['aprovado']);
    });
  }

  _onSuccessWeb(data) async {
    Navigator.pop(context);
    List sesiones = data["sesiones"];
    List<Sesion> listaAux = [];
    if (sesiones != null) {
      for (int i = 0; i < sesiones.length; i++) {
        listaAux.add(new Sesion(
            sesiones[i]["idsesion"],
            new Evento.setSesion(
                sesiones[i]["evento"],
                sesiones[i]["material_alumno"],
                sesiones[i]["descripcion"],
                sesiones[i]["idcategoria"],
                sesiones[i]["idtipoe"]),
            new Espacio(sesiones[i]["idespacio"], sesiones[i]["espacio"],
                sesiones[i]["espaciodesc"], 0),
            new Ponente.sinEncargado(
                sesiones[i]["idponente"],
                sesiones[i]["ponente"],
                sesiones[i]["biografia"],
                sesiones[i]["imagen"]),
            sesiones[i]["idfecha"],
            sesiones[i]["horainicio"],
            sesiones[i]["horafinal"],
            true));
        setState(() {
          lista = listaAux;
        });
      }
    }
  }

  void consumirDatos(String correo) {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${Strings.usuario}:${Strings.contrasena}'));
    String server = "${Strings.server}api/usuario";
    print(server);
    Future<String> getData() async {
      try {
        http.Response response = await http.post(Uri.encodeFull(server),
            headers: {
              "content-type": "application/json",
            },
            body: jsonEncode({"idUsuario": correo, "token": "1"}));
        print(response.body);
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data['valid'].toString() == '1') {
          _onSuccessAlumnoWeb(data);
        }
      } catch (e) {
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Ocurrió un error, inténtalo más tarde 😰",
                style: TextStyle(fontFamily: "GoogleSans"))));
      }
    }

    getData();
  }

  _onSuccessAlumnoWeb(data) async {
    Navigator.pop(context);
    if (data['alumno'] != null) {
      setState(() {
        idCarrera = data['alumno']['idcarrera'];
        nombre = data['alumno']['nombre'];
        noControl = data['alumno']['idusuario'];
        semestre = data['alumno']['semestre'];
        idEncargado = data['alumno']['idencargado'];
        sharedPreferences.setIdCarrera(idCarrera);
        sharedPreferences.setNombre(nombre);
        sharedPreferences.setNoControl(noControl);
        sharedPreferences.setSemestre(semestre);
        sharedPreferences.setIdEncargado(idEncargado);
        sharedPreferences.setFoto(foto);
      });
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => _onLoading(context));
      _MisActividades();
    }
  }

  void _cargar() async {
    await _getSharedPreferences();
    _Configuracion();
  }
}
