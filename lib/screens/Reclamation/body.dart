import 'package:flutter/material.dart';
import 'package:pim/components/default_button.dart';
import 'package:pim/components/global_repos.dart';
class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),

              ),
              SizedBox(
                height: 10,
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
                "Add your claim",
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
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.black87,
              ),
              SizedBox(
                height: 20,
              ),
              DefaultButton(
                text: "SEND",
                 press: () {
      apiData.addReclamation();
      },
              )
            ],
          ),
        ),
      ),
    );
  }
}
