import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/models/uploadebannermodel.dart';
import 'package:ecommerce/features/shop/screens/uploads/uploadbanner.dart';
import 'package:ecommerce/utils/http/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadBannerController {
  final targetScreen = TextEditingController();
  final imageUploading = false.obs;
  final image = ''.obs;
  final userRepository = Get.put(UserRepository());

  Future<void> getBannerImage() async {
    try {
      final picker = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (picker != null) {
        imageUploading.value = true;
        image.value = picker.path ?? '';

       // start loading 
        TFullScreenLoader.openLoadingDialog('Storing Address...');

          // Check internet 
        final isConnected = await NetworkManager.instance.isConnected();
        if(!isConnected){
          TFullScreenLoader.stopLoading();
          return;
        }
         final userRepository = Get.put(UserRepository());

        final imageUrl = await userRepository.uploadImage('Banners/', picker);
        
        final uploadBanner = UploadbannerModel(targetScreen: targetScreen.text, imageUrl: imageUrl, active: true);

        await userRepository.bannerrecord(uploadBanner);

        // Remove loadr 
          TFullScreenLoader.stopLoading();

        // Show Success Message 
        TLoaders.successSnackBar(title: 'Congratulations', message: 'Banner was uploaded successfully.');

        Get.to(() => const UploadBanner());



      }
    } catch (e) {
      // Remove loader 
        TFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString()); 
    }
  }
}
