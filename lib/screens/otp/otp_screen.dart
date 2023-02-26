import 'package:flutter/material.dart';
import 'package:pim/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  const OtpScreen({
    required this.email,
  });
  static String routeName = "/otp";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(email),
    );
  }
}
