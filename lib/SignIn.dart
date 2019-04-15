import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:semana_lince/Herramientas/SharedPreferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:semana_lince/Herramientas/Progress.dart';
import 'package:semana_lince/Herramientas/Strings.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:semana_lince/Principal/principal.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignIn();
  }
}

class _SignIn extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging firebase = new FirebaseMessaging();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  SharedPreferencesTest sharedPreferences = new SharedPreferencesTest();
  bool _success;
  String _userID, token, email, foto;
  int cont = 0;

  @override
  void initState() {
    super.initState();
    firebase.configure(
      onLaunch: (Map<String, dynamic> msg) {},
      onResume: (Map<String, dynamic> msg) {},
      onMessage: (Map<String, dynamic> msg) {},
    );
    firebase.getToken().then((token) {
      update(token);
    });
    getUser().then((user) {
      if (user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Principal()),
            ModalRoute.withName('/principal'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(children: <Widget>[
        NavigationBar(true),
        Container(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: Platform.isAndroid
                ? EdgeInsets.only(top: 150)
                : EdgeInsets.only(top: 150),
            child: Text(
              "¡Bienvenido!",
              style: TextStyle(
                  color: AppColors.colorAccent,
                  fontSize: 30.0,
                  fontFamily: "GoogleSans",
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 190, bottom: 20),
                    alignment: Alignment.center,
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 5.0,
                      color: Colors.white,
                      child: Container(
                          width: 250,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  cont += 1;
                                  if (cont == 15) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => _Milos(context));
                                    cont = 0;
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Image(
                                    height: 150,
                                    width: 150,
                                    image: AssetImage("assets/images/logo.png"),
                                  ),
                                ),
                              ),
                              Text(
                                "Inicia sesión con tu\ncuenta institucional",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "GoogleSans",
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.verdeDarkColor),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: new RaisedButton(
                                  onPressed: () async {
                                    _signInWithGoogle();
                                  },
                                  child: Text(
                                    "Ingresar",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "GoogleSans",
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.colorAccent),
                                    textAlign: TextAlign.center,
                                  ),
                                  color: AppColors.verdeDarkLightColor,
                                ),
                              )
                            ],
                          )),
                    )),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => _Lynxes(context));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          alignment: Alignment.center,
                          child: Text(
                            "Powered by: ",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "GoogleSans",
                                fontWeight: FontWeight.bold,
                                color: AppColors.azulMarino),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, right: 10),
                          alignment: Alignment.center,
                          child: Image(
                            height: 100,
                            width: 100,
                            image: AssetImage("assets/images/lynxes.png"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(),
                          alignment: Alignment.center,
                          child: Text(
                            "Club de Programación",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "GoogleSans",
                                fontWeight: FontWeight.bold,
                                color: AppColors.azulMarino),
                            textAlign: TextAlign.right,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }

  _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if (user != null) {
      _success = true;
      _userID = user.uid;
      if (currentUser.email.contains("itcelaya.edu")) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => _onSuccess(context),
        );
        consumirDatos(currentUser.email.split("@")[0]);
      } else {
        cerrarSesion();
        showDialog(
            context: context,
            builder: (context) =>
                _onError(context, "Esa no es tu cuenta institucional"));
      }
      foto = currentUser.photoUrl;
    } else {
      _success = false;
    }
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  void cerrarSesion() async {
    _googleSignIn.signOut();
    _auth.signOut();
  }

  _onSuccess(BuildContext context) {
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

  _Lynxes(BuildContext context) {
    return AssetGiffyDialog(
      image: Image.asset(
        'assets/images/hello.gif',
        fit: BoxFit.cover,
      ),
      title: Text(
        'Lynxes es un grupo estudiantil formado por alumnos de la carrera de Ingeniería en sistemas computacionales, nos enfocamos en soluciones de software, asesorías de programación y reparación de computadoras. 👨‍💻\n\nNos pueden encontrar en la parte superior de cafetería 3 en campus 2, estamos para ayudarlos. 😉',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 9,
            fontFamily: "GoogleSans",
            color: AppColors.azulMarino),
      ),
      onlyOkButton: true,
      buttonOkText: Text(
        "Aceptar",
        style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
      ),
      onOkButtonPressed: () {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => _Gracias(context));
      },
    );
  }
  _Gracias(BuildContext context) {
    return AssetGiffyDialog(
      image: Image.asset(
        'assets/images/gracias.gif',
        fit: BoxFit.cover,
      ),
      title: Text(
        'Queremos agradecer a Santiago Arturo Alvarado Alva y a Reyna Stephania Vera Carrizal por compartir sus fotos de algunos eventos representativos del TecNM en Celaya, además a todos aquellos que nos apoyaron con las pruebas para la corrección de errores y en especial al profesor Francisco Gutiérrez Verá quien fue el encargado del desarrollo.\n\nEsperamos que la aplicación sea de su agrado ya que es una app de estudiantes para estudiantes. 😉',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 8,
            fontFamily: "GoogleSans",
            color: AppColors.azulMarino),
      ),
      onlyOkButton: true,
      buttonOkText: Text(
        "Aceptar",
        style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
      ),
      onOkButtonPressed: () {
        Navigator.pop(context);
      },
    );
  }

  _Milos(BuildContext context) {
    return AssetGiffyDialog(
      image: Image.asset(
        'assets/images/milos.gif',
        fit: BoxFit.cover,
      ),
      title: Text(
        '¿Khe haces aki?',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 35,
            fontFamily: "GoogleSans",
            color: AppColors.verdeDarkLightColor),
      ),
      description: Text(
        '@JonathanLNB',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15,
            fontFamily: "GoogleSans",
            color: AppColors.azulMarino),
      ),
      onlyOkButton: true,
      buttonOkText: Text(
        "Aceptar",
        style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
      ),
      onOkButtonPressed: () {
        Navigator.pop(context);
      },
    );
  }

  _onError(BuildContext context, String texto) {
    return AssetGiffyDialog(
      image: Image.asset(
        'assets/images/errorf.gif',
        fit: BoxFit.cover,
      ),
      title: Text(
        'Error 😱',
        style: TextStyle(
            fontSize: 22,
            fontFamily: "GoogleSans",
            fontWeight: FontWeight.bold,
            color: AppColors.verdeDarkLightColor),
      ),
      description: Text(
        texto,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15,
            fontFamily: "GoogleSans",
            color: AppColors.azulMarino),
      ),
      onlyOkButton: true,
      buttonOkText: Text(
        "Aceptar",
        style: TextStyle(fontFamily: "GoogleSans", color: Colors.white),
      ),
      onOkButtonPressed: () {
        Navigator.pop(context);
      },
    );
  }

  void consumirDatos(String correo) {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${Strings.usuario}:${Strings.contrasena}'));
    String server = "${Strings.server}api/usuario";
    Future<String> getData() async {
      try {
        http.Response response = await http.post(Uri.encodeFull(server),
            headers: {"content-type": "application/json"},
            body: jsonEncode({"idUsuario": correo, "token": token}));
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data['valid'].toString() == '1') {
          _onSuccessWeb(data);
        } else {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) => _onError(
                  context, Strings.errorS));
        }
      } catch (e) {
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text(Strings.errorS,
                style: TextStyle(fontFamily: "GoogleSans"))));
      }
    }

    getData();
  }

  _onSuccessWeb(data) async {
    if (data['alumno'] != null) {
      sharedPreferences.setIdCarrera(data['alumno']['idcarrera']);
      sharedPreferences.setNombre(data['alumno']['nombre']);
      sharedPreferences.setNoControl(data['alumno']['idusuario']);
      sharedPreferences.setSemestre(data['alumno']['semestre']);
      sharedPreferences.setIdEncargado(data['alumno']['idencargado']);
      sharedPreferences.setFoto(foto);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Principal()),
          ModalRoute.withName('/principal'));
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              _onError(context, Strings.errorC));
      cerrarSesion();
    }
  }

  void update(String token) {
     this.token = token;
     print(token);
  }
}
