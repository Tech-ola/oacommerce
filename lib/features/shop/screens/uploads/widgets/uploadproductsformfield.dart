import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class productUploadFormFields extends StatelessWidget {
  const productUploadFormFields({
    super.key, required this.hintText, this.controller, this.suffixIcon,
  });

  final String hintText;
  final dynamic controller;
  final dynamic suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
     decoration: InputDecoration(
    hintText: hintText,
    suffixIcon: Icon(suffixIcon),
    
                  ),
              
                );
  }
}