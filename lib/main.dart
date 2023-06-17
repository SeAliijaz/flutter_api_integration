import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Day-01%20(post_model_data)/Screens/post_model_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      ///title of app
      title: 'Flutter API-Integration',

      ///debugShowCheckedModeBanner
      debugShowCheckedModeBanner: false,

      ///This is the route that is displayed first when the application is started normally,
      ///unless [initialRoute] is specified.
      /// It's also the route that's displayed if the [initialRoute] can't be displayed.
      home: PostModelScreen(),
    );
  }
}
