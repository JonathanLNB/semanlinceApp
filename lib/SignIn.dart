import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Principal/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  bool _success;
  String _userID;
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
              "🎉 Bienvenido 🎉",
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

  void _signInWithGoogle() async {
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
    setState(() {
      if (user != null) {
        _success = true;
        _userID = user.uid;
        print("Usuario: ${_userID}");
      } else {
        _success = false;
      }
    });
  }
}
