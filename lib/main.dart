import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Post-Method/Day-01-(SignUp)/Screen/sign_up_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///title of app
      title: 'Flutter API-Integration',

      ///debugShowCheckedModeBanner
      debugShowCheckedModeBanner: false,

      ///theme
      theme: ThemeData(
        ///Default Text Theme
        textTheme: GoogleFonts.firaSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),

      ///Home: [initial Route]
      home: SignUpScreen(),
    );
  }
}
