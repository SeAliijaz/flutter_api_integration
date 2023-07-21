import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;

  const CustomButton({
    super.key,
    this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
      child: MaterialButton(
        color: Colors.blue,
        height: 60.0,
        minWidth: MediaQuery.sizeOf(context).width,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        child: Text(
          title ?? "title",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
