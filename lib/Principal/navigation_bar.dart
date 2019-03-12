import 'dart:io';

import 'package:flutter/material.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/Herramientas/custom_shape_clipper.dart';

class NavigationBar extends StatelessWidget{
  bool tipo = false;
  NavigationBar(this.tipo);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipPath(
      clipper: CustomShapeClipper(),
      child: Container(
        height: Platform.isIOS ? 150 : 125,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              tipo?AppColors.azulMarino:AppColors.verdeDarkLightColor,
              tipo?AppColors.negro:AppColors.verdeDarkColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

}