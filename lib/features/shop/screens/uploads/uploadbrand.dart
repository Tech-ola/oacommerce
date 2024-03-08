import 'dart:io';

import 'package:ecommerce/features/shop/controllers/product/uploadbannercontroller.dart';
import 'package:ecommerce/features/shop/controllers/product/uploadbrandcontroller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

class UploadBrand extends StatelessWidget {
  const UploadBrand({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadBrand = UploadBrandController();
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
                     Text("Brand Upload!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  
                  SizedBox(
                    width: 270,
                    child: Text("Input the form correctly to add new brand", style: TextStyle(fontSize: 12),))
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
                      controller: uploadBrand.brandname,
                  decoration: InputDecoration(
                    hintText: "Name of Brand",
                    suffixIcon: Icon(Iconsax.link),
                    
                  ),
              
                ),

                  const SizedBox(height: 10,),

                
                    TextFormField(
                      controller: uploadBrand.availableproduct,
                  decoration: InputDecoration(
                    hintText: "Number of available product for this Brand",
                    suffixIcon: Icon(Iconsax.computing),
                    
                  ),
              
                ),

                  const SizedBox(height: 10,),

              TextButton(
              onPressed: () => uploadBrand.uploadBrand(), 
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
                      uploadBrand.imageUploading.value
                          ? Image.file(File((uploadBrand.image.value),), height: 100,)
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