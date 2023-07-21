import 'package:flutter/material.dart';
import 'package:flutter_api_integration/Constants/k.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final bool isInfoNeeded;

  CustomTextFormField({
    super.key,
    this.hintText,
    this.prefixIcon,
    required this.controller,
    this.isInfoNeeded = false,
  });

  @override
  Widget build(BuildContext context) {
    return isInfoNeeded == false
        ? Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(prefixIcon),
                hintText: hintText ?? "",
              ),
            ),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(prefixIcon),
                    hintText: hintText ?? "",
                    suffixIcon: IconButton(
                      onPressed: () {
                        AppConsts.showMessage(
                          context,
                          "How to Use?",
                          AppConsts.infoMessage,
                        );
                      },
                      icon: Icon(Icons.info_outline),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
