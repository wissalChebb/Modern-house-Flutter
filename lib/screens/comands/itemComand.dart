import 'package:flutter/material.dart';

import 'package:pim/screens/detailCommand/detailComand_screen.dart';

import 'package:pim/screens/login_success/login_success_screen.dart';

class itemComand extends StatelessWidget {
  const itemComand({super.key});
  static String routeName = "/detailCommandScreen";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
      context,
      DetailComandScreen.routeName,

    ),
      child:  Padding(
          padding: EdgeInsets.all(10),

          child: Card(
            margin: EdgeInsets.only(bottom: 50),
            color: Colors.deepOrangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),

            child: Padding(

                padding: EdgeInsets.all(10),

                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/download.jpg", height: 50, width: 50,
                      // ajuster l'image pour remplir complètement le conteneur
                    ),
                    SizedBox(height: 10,width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Category NAME "),
                        SizedBox(height: 10,),
                        Row(

                          children: [
                            Text("233 dt"),
                            SizedBox(width: 100,),
                            Text("Status")
                          ],
                        ),
                        Text("2020/10/03")
                      ],
                    )

                  ]
                )),)
      ),
    );
  }
}
