import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/models/productcategorymodel.dart';
import 'package:ecommerce/features/shop/screens/uploads/productcategory.dart';
import 'package:ecommerce/utils/http/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class productcategorycontroller {

  final products = TextEditingController();
  final category = TextEditingController();

  final userrepo = Get.put(UserRepository());

  void setProductsValue(String value){
    products.text = value; 
  }

    void setCategoryValue(String values){
    category.text = values; 
  }

  Future<void> uploadproductscategory() async{
    try{
          // start loading 
        TFullScreenLoader.openLoadingDialog('Storing Address...');

          // Check internet 
        final isConnected = await NetworkManager.instance.isConnected();
        if(!isConnected){
          TFullScreenLoader.stopLoading();
          return;
        }

        final productcategory = UploadProductCategoryModel(categoryId: category.text, productId: products.text);

        await userrepo.saveproductcategory(productcategory);

          // Remove loadr 
          TFullScreenLoader.stopLoading();

        // Show Success Message 
        TLoaders.successSnackBar(title: 'Congratulations', message: 'This Product aand Category were linked successfully.');

        Get.to(() => const UploadProductCategory());



    }catch(e){
       // Remove loader 
        TFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
       TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString()); 
   

    }

  }

  
}