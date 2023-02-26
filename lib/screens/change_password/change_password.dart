import 'package:flutter/material.dart';

import 'components/body.dart';

class ChangePassword extends StatelessWidget {
  static String routeName = "/ChangePassword";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("change Password"),
      ),
      body: Body(),
    );
  }
}
