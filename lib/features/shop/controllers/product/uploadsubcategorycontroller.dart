import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/models/uploadsubcategorymodel.dart';
import 'package:ecommerce/features/shop/screens/uploads/uploadsubcategory.dart';
import 'package:ecommerce/utils/http/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';

class UploadSubCategoryController { 
  final subcategoryname = TextEditingController();
  final category = TextEditingController();

  final imageUploading = false.obs;
  final userRepository = Get.put(UserRepository());

  final image = ''.obs;

  void setCategoryValue(String value) {
    category.text = value;
  }

  Future<void> uploadsubCategory() async {
    try {
      final picker = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (picker != null) {
        imageUploading.value = true;
        image.value = picker.path;

        // start loading
        TFullScreenLoader.openLoadingDialog('Storing Address...');

        // Check internet
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          TFullScreenLoader.stopLoading();
          return;
        }

        final imageUrl = await userRepository.uploadImage('Subcategory/', picker);

        
      // Generate a unique numeric ID
      final docId = DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(9999).toString();

        final subcategories = UploadSubCategoryModel(
          image: imageUrl,
          isFeatured: true,
          name: subcategoryname.text,
          parentId: category.text,
        );

        await userRepository.subcategoryrecord(docId, subcategories);

        // Remove loader
        TFullScreenLoader.stopLoading();

        // Show Success Message
        TLoaders.successSnackBar(title: 'Congratulations', message: 'Sub Category was uploaded successfully.');

        Get.to(() => const UploadSubCategory());
      }
    } catch (e) {
      // Remove loader
      TFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
