import 'package:ecommerce/data/repositories/product/product_repository.dart';
import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/features/shop/models/product_attribute_model.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/models/product_variation_model.dart';
import 'package:ecommerce/features/shop/models/uploadproduct_model.dart';
import 'package:ecommerce/features/shop/models/uploadproduct_variation_model.dart';
import 'package:ecommerce/features/shop/screens/uploads/uploadproducts.dart';
import 'package:ecommerce/utils/http/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';

class UploadProductController {
  final image = "".obs;

  final imagevariety1 = "".obs;
  final imagevariety2 = "".obs;
  final imagevariety3 = "".obs;
  final imagevariety4 = "".obs;


  final variationimage = "".obs;

  final thumbnail = "".obs;
  final brandImage = "".obs;
  final uploadimagevariety1 = "".obs;
  final uploadimagevariety2 = "".obs;
  final uploadimagevariety3 = "".obs;
  final uploadimagevariety4 = "".obs;
  final uploadvariation = "".obs;
  final uploadthumbnail = "".obs;


  final brandname = TextEditingController();
  final brand = TextEditingController(); 
  final productsCount = TextEditingController();
  final category = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();


  final color1 = TextEditingController();
  final color2 = TextEditingController();
  final color3 = TextEditingController();
  final size1 = TextEditingController();
  final size2 = TextEditingController();
  final size3 = TextEditingController();
  final productType = TextEditingController();


  final colorvariation = TextEditingController();
  final sizevariation = TextEditingController();
  final descriptionvariation = TextEditingController();
  final pricevariation = TextEditingController();
  final skuvariation = TextEditingController();
  final salepricevariation = TextEditingController();
  final stockvariation = TextEditingController();

  
  final productsku = TextEditingController();
  final productsaleprice = TextEditingController();
  final productstock = TextEditingController();
  final title = TextEditingController();
  

  final userRepository = Get.put(UserRepository());

  final productrepo = Get.put(ProductRepository());
  
  final imageUploading = false.obs;

  void setBrandValue(String value) {
    brand.text = value;
  }

 void setCategoryValue(String value) {
    category.text = value;
  }

void setProducttypeValue(String? value) {
  productType.text = value ?? ''; // Provide a default value if value is null
}



  Future<String?> getImage() async {
    final picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (picker != null) {
      // Perform heavy work off the main thread
      imageUploading.value = true;

       final imageUrl = await userRepository.uploadImage('Products/', picker);

      // Update the image path on the main thread
      Future.delayed(Duration.zero, () {
        image.value = picker.path;
        brandImage.value = imageUrl;
      
      });
    return imageUrl;
    }

    return null;

  }


    Future<String?> getVariety1() async {
    final picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (picker != null) {
      // Perform heavy work off the main thread
      imageUploading.value = true;

       final imageUrl = await userRepository.uploadImage('Products/', picker);

      // Update the image path on the main thread
      Future.delayed(Duration.zero, () {
        imagevariety1.value = picker.path;
        
        uploadimagevariety1.value = imageUrl;
      });
      return imageUrl;
    }


  }


  Future<String?> getVariety2() async {
    final picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (picker != null) {
      // Perform heavy work off the main thread
      imageUploading.value = true;

       final imageUrl = await userRepository.uploadImage('Products/', picker);

      // Update the image path on the main thread
      Future.delayed(Duration.zero, () {
        imagevariety2.value = picker.path;
        uploadimagevariety2.value = imageUrl;
      });
      return imageUrl;
    }
    return null;
  }

    Future<String?> getVariety3() async {
    final picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (picker != null) {
      // Perform heavy work off the main thread
      imageUploading.value = true;

       final imageUrl = await userRepository.uploadImage('Products/', picker);

      // Update the image path on the main thread
      Future.delayed(Duration.zero, () {
        imagevariety3.value = picker.path;
        uploadimagevariety3.value = imageUrl;
      });
      return imageUrl;
    }

    return null;
    
  }


    Future<String?> getVariety4() async {
    final picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (picker != null) {
      // Perform heavy work off the main thread
      imageUploading.value = true;
       final imageUrl = await userRepository.uploadImage('Products/', picker);

      // Update the image path on the main thread
      Future.delayed(Duration.zero, () {
        imagevariety4.value = picker.path;
        uploadimagevariety4.value = imageUrl;
      });
      return imageUrl;
    }
    return null;
  }

      Future<String?> getvariationimage() async {
    final picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (picker != null) {
      // Perform heavy work off the main thread
      imageUploading.value = true;
       final imageUrl = await userRepository.uploadImage('Products/', picker);

      // Update the image path on the main thread
      Future.delayed(Duration.zero, () {
        variationimage.value = picker.path;
        uploadvariation.value = imageUrl;
      });

      return imageUrl;
    }
    return null;
  }

      Future<String?> getthumbnail() async {
    final picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (picker != null) {
      // Perform heavy work off the main thread
      imageUploading.value = true;
       final imageUrl = await userRepository.uploadImage('Products/', picker);

      // Update the image path on the main thread
      Future.delayed(Duration.zero, () {
        
        thumbnail.value = picker.path;
        uploadthumbnail.value = imageUrl;

      });
    return imageUrl;
    }
    return null;

    
    }

     Future<void> uploadAllProducts() async {

      try {
        // Start loading
        TFullScreenLoader.openLoadingDialog('Storing Product...');

        // Check internet connection
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          TFullScreenLoader.stopLoading();
          return;
        }

    // Create ProductAttributes list
    List<ProductAttributeModel> attributes = [];
    if (color1.text.isNotEmpty && color2.text.isNotEmpty && color3.text.isNotEmpty) {
      attributes.add(ProductAttributeModel(name: 'Color', values: [color1.text, color2.text, color3.text]));
    }
    if (size1.text.isNotEmpty && size2.text.isNotEmpty && size3.text.isNotEmpty) {
      attributes.add(ProductAttributeModel(name: 'Size', values: [size1.text, size2.text, size3.text]));
    }

    // Create ProductVariations list
    List<UploadProductVariationModel>? variations = [];
    if (colorvariation.text.isNotEmpty && sizevariation.text.isNotEmpty && skuvariation.text.isNotEmpty) {
      final variationAttributeValues = {'Color': colorvariation.text, 'Size': sizevariation.text};
      final variation = UploadProductVariationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // You may want to generate a unique ID for each variation
        sku: skuvariation.text,
        image: uploadvariation.value,
        description: descriptionvariation.text,
        price: int.parse(pricevariation.text),
        salePrice: int.parse(salepricevariation.text),
        stock: int.parse(stockvariation.text),
        attributeValues: variationAttributeValues,
      );
      variations.add(variation);
    }
    

    // Create ProductModel
    final product = UploadProductModel(
       brand: BrandModel(
          id: brand.text,
          name: brandname.text,
          image: brandImage.value,
          isFeatured: true,
          productsCount: int.tryParse(productsCount.text) ?? 0,
        ),
        categoryId: category.text,
        description: description.text,

        images: [uploadimagevariety1.value, uploadimagevariety2.value, uploadimagevariety3.value,uploadimagevariety4.value],

        isFeatured: true,
        price: int.parse(price.text.trim()),

        productAttributes: attributes,

        productType: productType.text,

        productVariations: variations,

        sku: productsku.text,
        salePrice: int.parse(productsaleprice.text.trim()),
         stock: int.parse(productstock.text),
          thumbnail: uploadthumbnail.value,
          title: title.text,
     
      
     
    );


    // Upload the product to the repository
       await productrepo.saveproductrecord(product);
    // await userRepository.uploadImage(product);

    // Stop loading
    TFullScreenLoader.stopLoading();

    // Show success message
    TLoaders.successSnackBar(title: 'Success', message: 'Product uploaded successfully');

     Get.to(() => const UploadProducts());
  } catch (e) {
    // Stop loading
    TFullScreenLoader.stopLoading();

    // Show error message
    TLoaders.errorSnackBar(title: 'Error', message: e.toString());
  }
}

   





}
