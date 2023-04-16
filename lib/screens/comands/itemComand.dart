import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class itemComand extends StatelessWidget {
  const itemComand({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
          margin: EdgeInsets.only(bottom: 20),
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Image.asset(
                "assets/images/download.jpg", height: 50, width: 50,
                // ajuster l'image pour remplir complètement le conteneur
              ),
              Text("PRODUCT NAME 1")
            ],
          )),
    );
  }
}
