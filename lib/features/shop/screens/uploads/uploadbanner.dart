import 'dart:io';

import 'package:ecommerce/features/shop/controllers/product/uploadbannercontroller.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UploadBanner extends StatelessWidget {
  const UploadBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadController = UploadBannerController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: 
        Padding(
           padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Column(
                  children: [
                     Text("Banner Upload!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  
                  SizedBox(
                    width: 270,
                    child: Text("Input the form correctly to add new banner", style: TextStyle(fontSize: 12),))
                  ],
                 )
                ],
              ),

              SizedBox(height: 40,),

              Padding(
                padding: const EdgeInsets.all(15),
                child: 
                Column(
                  children: [
                    TextFormField(
                      controller: uploadController.targetScreen,
                  decoration: InputDecoration(
                    hintText: "Target Screen",
                    suffixIcon: Icon(Iconsax.link),
                    
                  ),
              
                ),

                  const SizedBox(height: 10,),

              TextButton(
              onPressed: () => uploadController.getBannerImage(), 
              child: Container(
                padding: EdgeInsets.all(17),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: TSizes.defaultSpace * 6,
                child: Obx(
                  () => Column(
                    children: [
                      uploadController.imageUploading.value
                          ? Image.file(File(uploadController.image.value), height: 100,)
                          : Text("Select Image for upload"),
                    ],
                  ),
                ),
              ),
            ),                  


                  ],
                )
              ),

              

          
            ],
          ),
        ),
      ),
    );
  }
}