

import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/utils/http/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{

  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final userController = Get.put(UserController());


 @override
void onInit() {
  String? rememberedEmail = localStorage.read('REMEMBER_ME_EMAIL');
  String? rememberedPassword = localStorage.read('REMEMBER_ME_PASSWORD');

  if (rememberedEmail != null) {
    email.text = rememberedEmail;
  }

  if (rememberedPassword != null) {
    password.text = rememberedPassword;
  }

  super.onInit();
}


  // Email & Password login 
  Future<void> emailAndPasswordSignIn() async {
       try {
      // Start Loading 
      TFullScreenLoader.openLoadingDialog('Loading....');
      

      // Check Internet Connectivity 
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
        }

      // Form Validation 
      // if(!loginFormKey.currentState!.validate()) {
      //   TFullScreenLoader.stopLoading();
      //   return;
      //   }

        // Save data if remeber me 
        if(rememberMe.value) {
          localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
          localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
        }

        // login user using email & password authentication 
        final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

        // Remove loader 
        TFullScreenLoader.stopLoading();

        // Redirect 
        AuthenticationRepository.instance.screenRedirect();

        } catch (e){
          TFullScreenLoader.stopLoading();
          TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
        }

  } 

    // Google SignIn Authentication 
        Future<void> googleSignIn() async{
          try{
             TFullScreenLoader.openLoadingDialog('Logging in....');

            //  Check Internet Connectivity 
            final isConnected = await NetworkManager.instance.isConnected();
            if(!isConnected){
              TFullScreenLoader.stopLoading();
              return;
            }
            // Google Authentication 
            final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

            // Save User Record 
            await userController.saveUserRecord(userCredentials);

            // Rmeove lpader 
            TFullScreenLoader.stopLoading();

            // Redirect 
            AuthenticationRepository.instance.screenRedirect();

          }catch(e){
            TFullScreenLoader.stopLoading();
            TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
          }
        }


}