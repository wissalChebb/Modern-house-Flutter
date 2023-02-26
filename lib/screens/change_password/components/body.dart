import 'package:flutter/material.dart';
import 'package:pim/components/socal_card.dart';
import 'package:pim/constants.dart';
import 'package:pim/screens/change_password/components/change_password_form.dart';
import 'package:pim/size_config.dart';

class Body extends StatelessWidget {
  final String email;
  Body(this.email);
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
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Enter New Password", style: headingStyle),

                SizedBox(height: SizeConfig.screenHeight * 0.08),
                ChangePasswordForm(email),
                SizedBox(height: SizeConfig.screenHeight * 0.08),

                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
