import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Post-Method/Day-02-(Upload-Media)/Screens/upload_media_screen.dart';

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

      ///Home: -> initial Route <-
      home: UploadMediaScreen(),
    );
  }
}
