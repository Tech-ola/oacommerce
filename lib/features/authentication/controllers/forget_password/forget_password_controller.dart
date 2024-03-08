
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:ecommerce/utils/http/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  // Variables 
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send Reset PASSWORD EMAIL 
  sendPasswordResetEmail() async {
    try {

        // Start Loading 
      TFullScreenLoader.openLoadingDialog('We are processing your information ...');
    
      

      // Check Internet Connectivity 
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
        }

      // Form Validation 
      if(!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
        }

        // sedn email to reset password 
        await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

        // Remove loader 
        TFullScreenLoader.stopLoading();

        // Show success screen 
        TLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password' . tr);

        // Redirect 
        Get.to(() => ResetPasword(email: email.text.trim()));


    } catch(e) {
      // Remove lOader 
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
       try {

        // Start Loading 
      TFullScreenLoader.openLoadingDialog('We are processing your information ...');
    
      

      // Check Internet Connectivity 
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
        }

        // sedn email to reset password 
        await AuthenticationRepository.instance.sendPasswordResetEmail(email);

        // Remove loader 
        TFullScreenLoader.stopLoading();

        // Show success screen 
        TLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password' . tr);


    } catch(e) {
      // Remove lOader 
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}