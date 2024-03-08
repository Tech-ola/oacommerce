import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/models/brandcategorymodel.dart';
import 'package:ecommerce/features/shop/models/brand_category_model.dart';
import 'package:ecommerce/utils/http/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadBrandCategoryController {
  final brands = TextEditingController();
  final category = TextEditingController();
  final userrepo = Get.put(UserRepository());

  void setBrandValue(String value){
    brands.text = value; 
  }

    void setCategoryValue(String values){
    category.text = values; 
  }

  Future<void> uploadCategory() async {
    try {
           // start loading 
        TFullScreenLoader.openLoadingDialog('Storing Address...');

          // Check internet 
        final isConnected = await NetworkManager.instance.isConnected();
        if(!isConnected){
          TFullScreenLoader.stopLoading();
          return;
        }

      final brandcategory = UploadBrandCategoryModel(brandid: brands.text, categoryid: category.text);
      // TLoaders.errorSnackBar(title: 'Oh Snap!', message: brands.text);
      
      await userrepo.savebrandcategory(brandcategory);

              // Show Success Message
        TLoaders.successSnackBar(title: 'Congratulations', message: 'You have successfully linked this brand and category.');

       // Remove loader 
        TFullScreenLoader.stopLoading();


    }
    catch(e){
      // Remove loader 
        TFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString()); 
  

    }
  }
   
}