import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Constants/k.dart';
import 'package:flutter_api_integration/Post-Method/Day-01-(Signup-Login)/Widgets/custom_button.dart';
import 'package:flutter_api_integration/Post-Method/Day-01-(Signup-Login)/Widgets/custom_textformfield.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ///TextEditingController
  final TextEditingController? emailController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();

  ///Submit Form
  void submitForm(String email, password) async {
    try {
      ///value assigned to a variable
      const String uri = "https://reqres.in/api/register";

      ///response
      var response = await http.post(
        Uri.parse(uri),
        body: {
          "email": email,
          "password": password,
        },
      );

      ///statusCode
      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body.toString());
        AppConsts.showMessage(
            context, "Congratulations!", "Account Created Successfully!");
      } else {
        AppConsts.showMessage(context, "Error", "Something Issue!");
      }
    } catch (e) {
      AppConsts.showMessage(context, "Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///Email Field
            CustomTextFormField(
              controller: emailController!,
              prefixIcon: Icons.email_outlined,
              hintText: "Enter Your Email",
              isInfoNeeded: true,
            ),

            ///Password Field
            CustomTextFormField(
              controller: passwordController!,
              prefixIcon: Icons.lock_outline,
              hintText: "Enter Your Password",
            ),

            ///Action Button
            CustomButton(
              title: "SignUp",
              onPressed: () {
                ///submit form method called
                submitForm(
                  emailController!.text.toString(),
                  passwordController!.text.toString(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
