import 'package:flutter/material.dart';
import 'package:semana_lince/Herramientas/appColors.dart';
import 'package:semana_lince/TDA/Persona.dart';

class UserInfo extends StatelessWidget {
  Persona persona;

  UserInfo(this.persona);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return headerInfo(context);
  }

  Container headerInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100.0),
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
                    persona.getNombre(),
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
                    persona.getCarrera(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grisObscuro,
                      fontSize: 15.0,
                      fontFamily: "GoogleSans",
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  persona.getNoControl(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "GoogleSans",
                                      color: AppColors.verdeDarkLightColor),
                                ),
                                subtitle: Text("No. Control",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "GoogleSans")),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        _onTapImage(context)); //
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage("assets/images/qr.png")),
                                ),
                              ),
                            )
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        _onTapImage(context)); //
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage("assets/images/signout.png")),
                                ),
                              ),
                            )
                          ]),
                    ],
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

  _onTapImage(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.network(
          "https://unitag-qr-code-generation.p.mashape.com/api?data={\"TYPE\":\"text\",\"DATA\":{\"TEXT\":\"" +
              persona.getNoControl() +
              "\"}}&setting={\"LAYOUT\":{\"COLORBG\":\"FFFFFF\",\"COLOR1\":\"5d9dcb\",\"COLOR2\":\"23ba41\",\"GRADIENT_TYPE\":\"DIAG1\"},\"EYES\":{\"EYE_TYPE\":\"Grid\"},\"E\":\"H\",\"BODY_TYPE\":0}",
          headers: {
            "X-Mashape-Key":
                "1F8Kl4KhQ0mshCmvdKfmHjJUv2pzp11rwE3jsnvREdfYdKIFLY"
          },
          fit: BoxFit.contain,
        ),
        // Show your Image
        Align(
          alignment: Alignment.topRight,
          child: RaisedButton.icon(
              color: AppColors.verdeDarkColor,
              textColor: Colors.white,
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              label: Text('Cerrar')),
        ),
      ],
    );
  }
}
