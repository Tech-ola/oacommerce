
import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/models/uplaodbrandmodel.dart';
import 'package:ecommerce/features/shop/screens/uploads/uploadbanner.dart';
import 'package:ecommerce/features/shop/screens/uploads/uploadbrand.dart';
import 'package:ecommerce/utils/http/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadBrandController {

  final brandname = TextEditingController();
  final availableproduct = TextEditingController();

  final imageUploading = false.obs;
  final userRepository = Get.put(UserRepository());
  
  final image = ''.obs;



  Future<void> uploadBrand() async {
    try{
      final picker = await ImagePicker().pickImage(source: ImageSource.gallery,
    imageQuality: 70,
    maxHeight: 512,
    maxWidth: 512,
    );

    if(picker != null){
      imageUploading.value = true;
      image.value = picker.path;

             // start loading 
        TFullScreenLoader.openLoadingDialog('Storing Address...');

          // Check internet 
        final isConnected = await NetworkManager.instance.isConnected();
        if(!isConnected){
          TFullScreenLoader.stopLoading();
          return;
        }

        final imageUrl = await userRepository.uploadImage('Brands/', picker);

      final uploadBrand = UploadBrandModel(
      id: '',
      brandname: brandname.text,
      availableproduct: int.parse(availableproduct.text),
      imageUrl: imageUrl,
      isFeatured: true,
    );
    await userRepository.brandrecord(uploadBrand);

         // Remove loadr 
          TFullScreenLoader.stopLoading();

        // Show Success Message 
        TLoaders.successSnackBar(title: 'Congratulations', message: 'Brand was uploaded successfully.');

        Get.to(() => const UploadBrand());

    }

    } catch(e){
      // Remove loader 
        TFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString()); 
    }  
    }


}