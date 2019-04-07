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
  int idCarrera = 9;
  int idEncargado = 1;
  int semestre = 0;
  String nombreAux = "";
  String noControlAux = "";
  String fotoAux = "";
  int idCarreraAux = 0;
  int idEncargadoAux = 0;
  int semestreAux = 0;

  @override
  void initState() {
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
    _getSharedPreferences();
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
              backgroundColor: AppColors.verdeDarkColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MostrarCategoria()),
                );
              },
              tooltip: 'Buscar',
              child: new Icon(
                Icons.search,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column getSad() {
    return Column(
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
                    textAlign: TextAlign.left,
                  )),
            )),
      ],
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
  }

  _getSharedPreferences() async {
    idCarreraAux = await sharedPreferences.getIdCarrera();
    nombreAux = await sharedPreferences.getNombre();
    fotoAux = await sharedPreferences.getFoto();
    noControlAux = await sharedPreferences.getNoControl();
    semestreAux = await sharedPreferences.getSemestre();
    idEncargadoAux = await sharedPreferences.getIdEncargado();
    setState(() {
      idCarrera = idCarreraAux;
      nombre = nombreAux;
      foto = fotoAux;
      noControl = noControlAux;
      semestre = semestreAux;
      idEncargado = idEncargadoAux;
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _onLoading(context));
    _MisActividades();
  }

  void _MisActividades() {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${Strings.usuario}:${Strings.contrasena}'));
    String server = "${Strings.server}api/movil/sesion/${noControl}";
    print(server);
    Future<String> getData() async {
      http.Response response = await http.get(Uri.encodeFull(server), headers: {
        "content-type": "application/json",
        "accept": "application/json"
      });
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['valid'].toString() == '1') {
        _onSuccessWeb(data);
      }
    }

    getData();
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
}
