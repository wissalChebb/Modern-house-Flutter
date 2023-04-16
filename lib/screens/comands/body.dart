import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pim/constants.dart';
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
                itemComand()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
