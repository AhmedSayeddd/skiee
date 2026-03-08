import 'package:flutter/material.dart';
import 'package:skiee/auth/pages/login_screen.dart';
import 'package:skiee/auth/pages/register_screen.dart';
import 'package:skiee/widget/bookedscreen.dart';
import 'package:skiee/widget/flightdetailsscreen.dart';
import 'package:skiee/widget/homescreem.dart';
import 'package:skiee/widget/profilescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        FlightDetailsScreen.routeName: (context) => FlightDetailsScreen(),
        BookedScreen.routeName: (context) => BookedScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
      },
    );
  }
}
