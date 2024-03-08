
import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/models/categoryuploadmodel.dart';
import 'package:ecommerce/features/shop/screens/uploads/uploadcategory.dart';
import 'package:ecommerce/utils/http/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';

class UploadCategoryController {
  final categoryName = TextEditingController();
  final imageUploading = false.obs;
  final image = ''.obs;
  final userRepository = Get.put(UserRepository());

  Future<void> uploadCategory() async {
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

      final imageUrl = await userRepository.uploadImage('Category/', picker);

      // Generate a unique numeric ID
      final docId = DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(9999).toString();

      final uploadCategory = UploadCategoryModel(
        categoryname: categoryName.text,
        imageUrl: imageUrl,
        isfeatured: true,
        parentid: "",
      );

      await userRepository.categoryrecord(docId, uploadCategory);

      // Remove loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Category was uploaded successfully.',
      );

      Get.to(() => const UploadCategory());
    }
  } catch (e) {
    // Remove loader
    TFullScreenLoader.stopLoading();

    TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  }
}
}