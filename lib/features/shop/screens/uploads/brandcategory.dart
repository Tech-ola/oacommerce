import 'dart:io';

import 'package:ecommerce/data/repositories/categories/category_repository.dart';
import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/shop/controllers/product/brandcategroycontroller.dart';
import 'package:ecommerce/features/shop/controllers/product/uploadbannercontroller.dart';
import 'package:ecommerce/features/shop/controllers/product/uploadbrandcontroller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

class BrandCategory extends StatefulWidget {
  const BrandCategory({super.key});

  @override
  State<BrandCategory> createState() => _BrandCategoryState();
}

class _BrandCategoryState extends State<BrandCategory> {
  final getbrands = UserRepository(); 
  late String selectedOption;
  late String categoryOption;
  final uploadBrandCategory = UploadBrandCategoryController();

    @override
  void initState() {
    super.initState();
    selectedOption = ''; // Initialize selectedOption
    categoryOption = '';
  }


  @override
  Widget build(BuildContext context) {
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
                     Text("List Brands to Category!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  
                  SizedBox(
                    width: 270,
                    child: Text("Kindly make a selection to link records", style: TextStyle(fontSize: 12),))
                  ],
                 )
                ],
              ),

              SizedBox(height: 40,),
              
              FutureBuilder<List<Map<String, dynamic>>>(
              future: getbrands.getBrands(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // This might be causing the issue
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                          List<Map<String, dynamic>> brands = snapshot.data ?? [];
                          List<DropdownMenuItem<String>> dropdownItems = [];
                          
                          for (var brand in brands) {
                            String id = brand['id'];
                            String name = brand['name'];
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
                                child: Text('No brand found'),
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
                              uploadBrandCategory.setBrandValue(selectedOption);
                            },
                            items: dropdownItems,
                            decoration: InputDecoration(
                              labelText: 'Select a brand',
                              border: OutlineInputBorder(),
                            ),
                          );
                        }
                      },
                    ),


                    SizedBox(height: 15,),

                      FutureBuilder<List<Map<String, dynamic>>>(
              future: getbrands.getuploadCategory(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // This might be causing the issue
                } else if (snapshots.hasError) {
                  return Text('Error: ${snapshots.error}');
                } else {
                          List<Map<String, dynamic>> brands = snapshots.data ?? [];
                          List<DropdownMenuItem<String>> dropdownItems = [];
                          
                          for (var category in brands) {
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
                                child: Text('No brand found'),
                              ),
                            );
                          }

                          if(categoryOption.isEmpty && dropdownItems.isNotEmpty) {
                            categoryOption = dropdownItems.first.value ?? '';
                          }
                          
                          return DropdownButtonFormField<String>(
                            value: categoryOption,
                            onChanged: (newValue) {
                              setState(() {
                                categoryOption = newValue ?? '';
                              });
                                      // Set the selected option
                              uploadBrandCategory.setCategoryValue(categoryOption);
                            },
                            items: dropdownItems,
                            decoration: InputDecoration(
                              labelText: 'Select a Category',
                              border: OutlineInputBorder(),
                            ),
                          );
                        }
                      },
                    ),



             
                    
                      SizedBox(height: TSizes.defaultSpace * 2),
                    TextButton(
                      onPressed: () => uploadBrandCategory.uploadCategory(), 
                      child: Container(
                        padding: EdgeInsets.all(17),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                          width: TSizes.defaultSpace * 15,
                          child: Text("Link Brand and Category", textAlign: TextAlign.center,),
                      ))

          
            ],
          ),
        ),
      ),
    );

  }
}