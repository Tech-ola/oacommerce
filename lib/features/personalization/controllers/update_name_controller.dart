

import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/features/personalization/screens/profile/profile.dart';
import 'package:ecommerce/utils/http/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  // Init user data when home screen appears 
  @override
  void onInit(){
    initializeNames();
    super.onInit();
  }

  // Fetch user record  
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // start loading 
      TFullScreenLoader.openLoadingDialog('We are updating your information');

      // Check Internet Connectivity 
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
        }

      // Form Validation 
      // if(!updateUserNameFormKey.currentState!.validate()) {
      //   TFullScreenLoader.stopLoading();
      //   return;
      //   }

        // Update user first & last naem 
        Map<String, dynamic> name = {'FirstName': firstName.text.trim(), 'LastName': lastName.text.trim()};
        await userRepository.updateSingleField(name);

        // Update the Rx user value 
        userController.user.value.firstName = firstName.text.trim();
        userController.user.value.lastName = lastName.text.trim();

        // Remove Loader 
        TFullScreenLoader.stopLoading();

        // Show success message 
        TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Name has been updated');

        // Move to previous screen 
        Get.off(() => const ProfileScreen());

    }catch(e){
      // Remove loader 
        TFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString()); 

    }
  }


}