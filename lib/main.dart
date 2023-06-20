import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Day-03%20(users_model)/Screen/user_screen.dart';
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

      ///This is the route that is displayed first when the application is started normally,
      ///unless [initialRoute] is specified.
      /// It's also the route that's displayed if the [initialRoute] can't be displayed.
      home: UserModelScreen(),
    );
  }
}
