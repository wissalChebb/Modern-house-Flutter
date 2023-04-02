import 'package:flutter/material.dart';
import 'package:pim/components/default_button.dart';
import 'package:pim/screens/details/components/body.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(60.0)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60.0),
                          child: Image.asset(
                            "assets/images/download.jpg",
                            fit: BoxFit
                                .cover, // ajuster l'image pour remplir complètement le conteneur
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "esm user",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Divider(
                  color: Colors.black87,
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          "assets/images/download.jpg",
                          // ajuster l'image pour remplir complètement le conteneur
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "Product Name",
                          style: TextStyle(fontSize: 20),
                        ),
                        Rating()
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Divider(
                  color: Colors.black87,
                ),
                Text(
                  "Subject",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 30),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText:
                        'What is the most important thing to know about a product?',
                    labelText: 'title',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text) {
                    // Cette fonction est appelée à chaque fois que le texte est modifié
                    print('Nouveau texte: $text');
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Divider(
                  color: Colors.black87,
                ),
                Text(
                  "Add a review",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 30),
                ),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText:
                        'What did you like and didn\'t like ?Why did you use this product?',
                    labelText: 'Review',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text) {
                    // Cette fonction est appelée à chaque fois que le texte est modifié
                    print('Nouveau texte: $text');
                  },
                ),
                Divider(
                  color: Colors.black87,
                ),
                SizedBox(
                  height: 20,
                ),
                DefaultButton(
                  text: "Share Review",
                  press: () {
                    //Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
