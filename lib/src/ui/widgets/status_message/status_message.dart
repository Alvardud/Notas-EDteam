import 'package:aplicacion_notas_edteam/src/core/constants/parameters.dart';
import 'package:aplicacion_notas_edteam/src/core/controllers/theme_controller.dart';
import 'package:aplicacion_notas_edteam/src/ui/configure.dart';
import 'package:flutter/material.dart';

class StatusMessage extends StatelessWidget {
  final Function() onTap;
  final StatusNetwork status;

  StatusMessage(this.onTap, this.status, {Key? key}) : super(key: key);

  Color fontColor() =>
      !ThemeController.instance.brightnessValue ? Colors.white : Colors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            status == StatusNetwork.NoInternet
                ? "No hay una conexion a internet"
                : "Ocurrió una excepción",
            style: TextStyle(
                color: fontColor(), fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Configure.BACKGROUND_LIGHT,
                borderRadius: BorderRadius.circular(150)),
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(status == StatusNetwork.NoInternet
                          ? "assets/nointernet.png"
                          : "assets/error.png"))),
            ),
          ),
          Column(
            children: [
              Text(
                "Por favor intente de nuevo",
                style: TextStyle(color: fontColor()),
              ),
              TextButton(child: Text("Volver a intentar"), onPressed: onTap)
            ],
          )
        ],
      ),
    );
  }
}
