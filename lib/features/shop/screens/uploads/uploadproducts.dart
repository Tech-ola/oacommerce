import 'dart:io';

import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/shop/controllers/product/uploadproductscontroller.dart';
import 'package:ecommerce/features/shop/screens/uploads/widgets/uploadProductImage.dart';
import 'package:ecommerce/features/shop/screens/uploads/widgets/uploadproductsformfield.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';


class UploadProducts extends StatefulWidget {
  const UploadProducts({Key? key}) : super(key: key);

  @override
  State<UploadProducts> createState() => _UploadProductsState();
}

class _UploadProductsState extends State<UploadProducts> {
  String? _selectedItem;
  final categoryrepo = UserRepository();
  final uploadcontroller = UploadProductController();
    late String selectedOption;
    late String selectedbrandOption;


  @override
   void initState() {
    super.initState();
    selectedOption = ''; // Initialize selectedOption
    selectedbrandOption = '';
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Product Upload!",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 270,
                        child: Text(
                          "Input the form correctly to add new product",
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      "Brand Details",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: TSizes.defaultSpace),
                    
                    productUploadFormFields(hintText: 'Brand Name', suffixIcon: Iconsax.briefcase, controller: uploadcontroller.brandname),
                    SizedBox(height: 15),

                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: categoryrepo.getBrands(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<Map<String, dynamic>> categories = snapshot.data ?? [];
                          List<DropdownMenuItem<String>> dropdownItems = [];
                          
                          for (var category in categories) {
                            String id = category['id'];
                            String name = category['name'];
                            if (id.isNotEmpty) {
                              dropdownItems.add(
                                DropdownMenuItem<String>(
                                  value: id,
                                  child: Text(name),
                                ),
                              );
                       
                            }
                          }
                          
                          if (dropdownItems.isEmpty) {
                            dropdownItems.add(
                              DropdownMenuItem<String>(
                                value: '', // Add a dummy value if dropdownItems is empty
                                child: Text('No brands found'),
                              ),
                            );
                          }

                          if(selectedOption.isEmpty && dropdownItems.isNotEmpty) {
                            selectedOption = dropdownItems.first.value ?? '';
                          }
                          
                          return DropdownButtonFormField<String>(
                            value: selectedOption,
                            onChanged: (newValue) {
                              setState(() {
                                selectedOption = newValue ?? '';
                              });
                                      // Set the selected option
                              // subcategorycontroller.setCategoryValue(selectedOption);
                                
                              uploadcontroller.setBrandValue(selectedOption);
                            },
                            items: dropdownItems,
                            decoration: InputDecoration(
                              labelText: 'Select a Brand',
                              border: OutlineInputBorder(),
                            ),
                          );
                        }
                      },
                    ),

                    SizedBox(height: 15),

                   uploadproductImage(onTap: () => uploadcontroller.getImage(),  imagetext: 'Select Brand Image'),
                     SizedBox(height: 5),
                   
                   Obx(() => uploadcontroller.image.value != '' ?  Image.file(File(uploadcontroller.image.value), height: 100,): Container()),

                    SizedBox(height: 15),
                    productUploadFormFields(hintText: 'Products Count', suffixIcon: Iconsax.briefcase, controller: uploadcontroller.productsCount),
                    SizedBox(height: 15),

                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: categoryrepo.getsubCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<Map<String, dynamic>> categories = snapshot.data ?? [];
                          List<DropdownMenuItem<String>> dropdownItems = [];
                          
                          for (var category in categories) {
                            String id = category['id'];
                            String name = category['name'];
                            if (id.isNotEmpty) {
                              dropdownItems.add(
                                DropdownMenuItem<String>(
                                  value: id,
                                  child: Text(name),
                                ),
                              );
                       
                            }
                          }
                          
                          if (dropdownItems.isEmpty) {
                            dropdownItems.add(
                              DropdownMenuItem<String>(
                                value: '', // Add a dummy value if dropdownItems is empty
                                child: Text('No categories found'),
                              ),
                            );
                          }

                          if(selectedbrandOption.isEmpty && dropdownItems.isNotEmpty) {
                            selectedbrandOption = dropdownItems.first.value ?? '';
                          }
                          
                          return DropdownButtonFormField<String>(
                            value: selectedbrandOption,
                            onChanged: (newValue) {
                              setState(() {
                                selectedbrandOption = newValue ?? '';
                              });
                                      // Set the selected option
                              // subcategorycontroller.setCategoryValue(selectedOption);
                              uploadcontroller.setCategoryValue(selectedOption);
                            },
                            items: dropdownItems,
                            decoration: InputDecoration(
                              labelText: 'Select a category',
                              border: OutlineInputBorder(),
                            ),
                          );
                        }
                      },
                    ),

                    SizedBox(height: 15),

                    productUploadFormFields(hintText: 'Description', suffixIcon: Iconsax.briefcase, controller: uploadcontroller.description),
                    SizedBox(height: TSizes.defaultSpace * 2),
                    Text(
                      "Select Image Varieties",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: TSizes.defaultSpace),
                    uploadproductImage(imagetext: 'Select Image1', onTap: () => uploadcontroller.getVariety1()),

                     SizedBox(height: 5),
                   
                   Obx(() => uploadcontroller.imagevariety1.value != '' ?  Image.file(File(uploadcontroller.imagevariety1.value), height: 100,): Container()),


                    SizedBox(height: TSizes.defaultSpace),
                    uploadproductImage(imagetext: 'Select Image2', onTap: () => uploadcontroller.getVariety2()),

                     SizedBox(height: 5),
                   
                   Obx(() => uploadcontroller.imagevariety2.value != '' ?  Image.file(File(uploadcontroller.imagevariety2.value), height: 100,): Container()),


                    SizedBox(height: TSizes.defaultSpace),

                    uploadproductImage(imagetext: 'Select Image3', onTap: () => uploadcontroller.getVariety3()),
                     SizedBox(height: 5),
                   
                   Obx(() => uploadcontroller.imagevariety3.value != '' ?  Image.file(File(uploadcontroller.imagevariety3.value), height: 100,): Container()),

                    SizedBox(height: TSizes.defaultSpace),
                    uploadproductImage(imagetext: 'Select Image4', onTap: ()=> uploadcontroller.getVariety4()),

                     SizedBox(height: 5),
                   
                   Obx(() => uploadcontroller.imagevariety4.value != '' ?  Image.file(File(uploadcontroller.imagevariety4.value), height: 100,): Container()),

                    SizedBox(height: 15),
                    productUploadFormFields(hintText: 'Price', suffixIcon: Iconsax.money, controller: uploadcontroller.price),
                    SizedBox(height: TSizes.defaultSpace * 2),
                    SizedBox(height: TSizes.defaultSpace),
                    Text(
                      "Add Color Product Availables",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'Color 1', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.color1),
                    SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'Color 2', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.color2),
                    SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'Color 3', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.color3),
                    SizedBox(height: TSizes.defaultSpace * 2),
                    
                    Text(
                      "Add Size of Product Availables",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'Size 1', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.size1),
                    SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'Size 2', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.size2),
                    SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'Size 3', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.size3),
                    SizedBox(height: TSizes.defaultSpace),

                    SizedBox(height: TSizes.defaultSpace * 2),

                     Text( "Select Product Type",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                      value: _selectedItem,
                      items: <String?>['ProductType.variable', 'ProductType.single'].map((String? value) {
                        return DropdownMenuItem<String>(
                          value: value ?? '', // Handle null value by providing a default empty string
                          child: Text(value ?? ''), // Handle null value by providing a default empty string
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedItem = newValue ?? ''; // Handle null value by providing a default empty string
                          uploadcontroller.setProducttypeValue(newValue); // Pass newValue directly to the method
                        });
                      },
                    ),
                                          ),
                    ),

                    SizedBox(height: TSizes.defaultSpace * 2),

                     Text( "Add Product Variation",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),

                      SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'Color', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.colorvariation),

                     SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'Size', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.sizevariation),

                    SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'Description', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.descriptionvariation),

                    SizedBox(height: TSizes.defaultSpace),
                    uploadproductImage(imagetext: 'Image', onTap: () => uploadcontroller.getvariationimage()),

                       SizedBox(height: 5),
                   
                   Obx(() => uploadcontroller.variationimage.value != '' ?  Image.file(File(uploadcontroller.variationimage.value), height: 100,): Container()),

                    SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'Price', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.pricevariation),

                      SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'SKU', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.skuvariation),

                      SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'SalePrice', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.salepricevariation),

                      SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'Stock', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.stockvariation),


                    // Product Details 
                      SizedBox(height: TSizes.defaultSpace * 2),
                     Text( "Product Details",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),


                      SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'SKU', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.productsku),

                      SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'SalePrice', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.productsaleprice),

                      SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'Stock', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.productstock), 
                       SizedBox(height: TSizes.defaultSpace),

                      uploadproductImage(imagetext: 'Upload Thumnail', onTap: () => uploadcontroller.getthumbnail()),

                         SizedBox(height: 5),
                   
                   Obx(() => uploadcontroller.thumbnail.value != '' ?  Image.file(File(uploadcontroller.thumbnail.value), height: 100,): Container()),

                      SizedBox(height: TSizes.defaultSpace),
                    productUploadFormFields(hintText: 'Title', suffixIcon: Iconsax.color_swatch, controller: uploadcontroller.title),


                      SizedBox(height: TSizes.defaultSpace * 2),
                    TextButton(
                      onPressed: () => uploadcontroller.uploadAllProducts(), 
                      child: Container(
                        padding: EdgeInsets.all(17),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                          width: TSizes.defaultSpace * 15,
                          child: Text("Create New Product", textAlign: TextAlign.center,),
                      ))



                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
