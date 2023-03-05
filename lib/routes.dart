import 'package:flutter/widgets.dart';
import 'package:pim/screens/cart/cart_screen.dart';
import 'package:pim/screens/change_password/change_password.dart';
import 'package:pim/screens/complete_profile/complete_profile_screen.dart';
import 'package:pim/screens/details/details_screen.dart';
import 'package:pim/screens/forgot_password/forgot_password_screen.dart';
import 'package:pim/screens/home/home_screen.dart';
import 'package:pim/screens/login_success/login_success_screen.dart';
import 'package:pim/screens/otp/otp_screen.dart';
import 'package:pim/screens/profile/profile_screen.dart';
import 'package:pim/screens/sign_in/sign_in_screen.dart';
import 'package:pim/screens/splash/splash_screen.dart';
import 'package:pim/screens/product/product_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'package:pim/screens/WishList/WishScreen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  //CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ProductListScreen.routeName: (context) => ProductListScreen(),
  WishlistScreen.routeName: (context) => WishlistScreen(),
};
