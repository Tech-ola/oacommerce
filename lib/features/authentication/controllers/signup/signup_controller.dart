
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce/utils/http/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variable 
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName= TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName= TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // SIGN UP 
  void signup() async {
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
      if(!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
        }


      // Privacy Policy Check 
      if(!privacyPolicy.value){
        TFullScreenLoader.stopLoading();
        
        TLoaders.warningSnackBar(title: 'Accept Privacy Policy',
        message: 'Inorder to create account, you have to read and accept the Privacy Policy & Terms of use.',
        );
        return;
      }

      // Register user with firebase 
     final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());


    // Save Authenticated user 
    final newuser = UserModel(
      id: userCredential.user!.uid,
      firstName: firstName.text.trim(),
      lastName: lastName.text.trim(),
      username: username.text.trim(),
      email: email.text.trim(),
      phoneNumber: phoneNumber.text.trim(),
      profilePicture: '',

    );

    final userRepository = Get.put(UserRepository());
    await userRepository.saveUserRecord(newuser);

    // Remove loadr 
      TFullScreenLoader.stopLoading();

    // Show Success Message 
    TLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue.');

    // Move to verify email screen 
    Get.to(() => VerifyEmailScreen(email: email.text.trim(),));


    }catch (e){
      // Remove loader 
        TFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString()); 
    }
  }
}