import 'package:flutter/material.dart';
import 'package:pim/screens/Reclamation/reclamation_Screen.dart';
import 'package:pim/screens/detailCommand/Body.dart';

class DetailComandScreen extends StatelessWidget {

  static String routeName = "/detailCommandScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('My Product',style:TextStyle(color: Colors.black),),

      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Add you'r claime"),
              InkWell(
                child: Icon(Icons.link),
                onTap: () => Navigator.pushNamed(
                  context,
                  ReclamationScreen.routeName,

                ),
              ),
            ],
          ),

          Body()
        ],
      )


    );
  }
}
