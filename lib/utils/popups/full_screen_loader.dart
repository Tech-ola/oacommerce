import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text) {
showDialog(
  context: Get.overlayContext!,
  barrierDismissible: false,
  builder: (_) => const Center(
    child: SizedBox(
      width: 50.0, // Adjust width as needed
      height: 50.0, // Adjust height as needed
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey, // Change the background color of the indicator
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Change the color of the indicator
        strokeWidth: 4, // Adjust the thickness of the indicator
      ),
    ),
  ),
);

  }


  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
