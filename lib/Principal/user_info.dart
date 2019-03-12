import 'package:flutter/material.dart';
import 'package:semana_lince/Herramientas/appColors.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return headerInfo(context);
  }

  Container headerInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 140.0),
      height: 250.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "Jonathan Leonardo Nieto Bustamante",
                    style: TextStyle(
                      color: AppColors.verdeColor,
                      fontSize: 20.0,
                      fontFamily: "GoogleSans",
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Ingenieria en Sistemas Computacionales",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grisObscuro,
                      fontSize: 15.0,
                      fontFamily: "GoogleSans",
                    ),
                  ),
                  Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "15030089",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "GoogleSans",
                                  color: AppColors.verdeDarkLightColor),
                            ),
                            subtitle: Text("No. Control",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12.0, fontFamily: "GoogleSans")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage('assets/images/io.jpg'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
