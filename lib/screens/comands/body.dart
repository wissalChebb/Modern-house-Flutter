import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pim/components/API_Consumer.dart';

import 'package:pim/components/global_repos.dart';
import 'package:pim/constants.dart';
import 'package:pim/models/Cart.dart';
import 'package:pim/models/User.dart';
import 'package:pim/screens/comands/itemComand.dart';
import 'package:pim/size_config.dart';

class body extends StatelessWidget {
  const body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("My Orders", style: headingStyle),
                SizedBox(height: SizeConfig.screenHeight * 0.06),

                FutureBuilder<List<Cart>>(
                  future: API_Consumer.getCommandUserFromBackend(),
                  //stream: apiData.Commands,
                  initialData: UnmodifiableListView([]),
                  builder: (context, snapshot) {
                    print("wissal async " + snapshot.toString());
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    print("wissal widget");
                    print(snapshot.data!);
                    return Column(
                      //print(snapshost.data!);
                      children: snapshot.data!
                          .map((e) => itemCommand(cart: e))
                          //.map((e) => Text("Hello"))
                          .toList(),
                    );
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
