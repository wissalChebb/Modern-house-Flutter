import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pim/components/coustom_bottom_nav_bar.dart';
import 'package:pim/enums.dart';
import 'package:pim/screens/comands/body.dart';

class ComandScreen extends StatelessWidget {
  static String routeName = "/command";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello "),
      ),
      body: body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
