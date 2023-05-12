import 'package:flutter/material.dart';
import 'package:pim/models/User.dart';
import 'package:pim/screens/comands/comand_screen.dart';
import 'package:pim/screens/complete_profile/complete_profile_screen.dart';
import 'package:pim/screens/sign_in/components/sign_form.dart';
import 'package:pim/screens/sign_in/sign_in_screen.dart';
import 'package:pim/screens/WishList/WishScreen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () =>
                {Navigator.pushNamed(context, CompleteProfileScreen.routeName)},
          ),
          ProfileMenu(
            text: "Wishlist",
            icon: "assets/icons/Heart Icon.svg",
            press: () {
              Navigator.pushNamed(context, WishlistScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "My orders",
            icon: "assets/icons/Bell.svg",
            press: () {
              Navigator.pushNamed(context, ComandScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              user = null;
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
