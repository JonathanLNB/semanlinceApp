import 'dart:io';
import 'package:flutter/material.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Principal/principal.dart';
import 'package:semana_lince/SignIn.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Semana Lince',
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: SplashScreen(
        seconds: 5,
        navigateAfterSeconds: SignIn(),
        image: Image.asset("assets/images/logo.png"),
        photoSize: 60,
        loaderColor: AppColors.verdeDarkColor,
      ),
    ),
    routes: <String, WidgetBuilder>{
      '/principal': (BuildContext context) => new Principal(),
      '/signIn': (BuildContext context) => new SignIn(),
    },
  ));
}
