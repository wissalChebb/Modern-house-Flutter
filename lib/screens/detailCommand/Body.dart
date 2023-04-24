import 'package:flutter/material.dart';
import 'package:pim/components/default_button.dart';
import 'package:pim/screens/home/home_screen.dart';
import 'package:pim/size_config.dart';
class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      Padding(padding: EdgeInsets.all(10),


      child: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/download.jpg", height: 60, width: 60,
                // ajuster l'image pour remplir complètement le conteneur
              ),
              SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("titre"),
                  Text("description")

                ],
              )

            ],
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/download.jpg", height: 60, width: 60,
                // ajuster l'image pour remplir complètement le conteneur
              ),
              SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("titre"),
                  Text("description")

                ],
              )

            ],
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/download.jpg", height: 60, width: 60,
                // ajuster l'image pour remplir complètement le conteneur
              ),
              SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("titre"),
                  Text("description")

                ],
              )

            ],
          )

        ],
      )
     );


  }
}
