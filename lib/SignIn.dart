import 'dart:convert';
import 'dart:io';
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
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  SharedPreferencesTest sharedPreferences = new SharedPreferencesTest();
  bool _success;
  String _userID, email, foto;

  @override
  void initState() {
    super.initState();
    getUser().then((user) {
      if (user != null) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Principal()), ModalRoute.withName('/principal'));
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
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  height: 150,
                                  width: 150,
                                  image: AssetImage("assets/images/logo.png"),
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
                Container(
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
                )
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
        showDialog(context: context,barrierDismissible: false, builder: (context) => _onSuccess(context),);
        consumirDatos(currentUser.email.split("@")[0]);
      } else {
        showDialog(context: context, builder: (context) => _onError(context, "Esa no es tu cuenta institucional"));
        cerrarSesion();
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

  _onError(BuildContext context, String texto) {
    return Material(
        color: Colors.transparent,
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Container(
              width: 300,
              height: 250,
              margin: EdgeInsets.all(50),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      image: new AssetImage("assets/images/fondo.png"),
                      fit: BoxFit.none,
                      repeat: ImageRepeat.repeat),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 7.0))
                  ]),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/sad.png'),
                    )),
                  ),
                  Container(
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 5.0,
                        color: Colors.white,
                        child: Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Text(
                              texto,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "GoogleSans",
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.azulMarino),
                              textAlign: TextAlign.center,
                            )),
                      ))
                ],
              )),
          Align(
            alignment: Alignment.topRight,
            child: RaisedButton.icon(
                color: AppColors.azulMarino,
                textColor: Colors.white,
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                label: Text('Cerrar')),
          )
        ]));
  }

  void consumirDatos(String correo) {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${Strings.usuario}:${Strings.contrasena}'));
    String server = "${Strings.server}api/usuario";
    print(server);
    Future<String> getData() async {
      http.Response response = await http.post(Uri.encodeFull(server),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          },
          body: jsonEncode({"idUsuario": correo, "token": "1"}));
      print(response.body);
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['valid'].toString() == '1') {
        _onSuccessWeb(data);
      }
    }

    getData();
  }

  _onSuccessWeb(data) async {
    if(data['alumno'] != null) {
      sharedPreferences.setIdCarrera(data['alumno']['idcarrera']);
      sharedPreferences.setNombre(data['alumno']['nombre']);
      sharedPreferences.setNoControl(data['alumno']['idusuario']);
      sharedPreferences.setSemestre(data['alumno']['semestre']);
      sharedPreferences.setIdEncargado(data['alumno']['idencargado']);
      sharedPreferences.setFoto(foto);
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => Principal()),
          ModalRoute.withName('/principal'));
    }
    else {
      showDialog(context: context,
          builder: (context) =>
              _onError(context, "Esta cuenta no esta registrada"));
      cerrarSesion();
    }
  }

}
