import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/shop/controllers/product/uploadsubcategorycontroller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

class UploadSubCategory extends StatefulWidget {
  const UploadSubCategory({Key? key}) : super(key: key);

  @override
  _UploadSubCategoryState createState() => _UploadSubCategoryState();
}

class _UploadSubCategoryState extends State<UploadSubCategory> {
  final categoryrepo = UserRepository();
  final subcategorycontroller = UploadSubCategoryController();
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = ''; // Initialize selectedOption
  }

  @override
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
              Text("Subcategory Upload!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      controller: subcategorycontroller.subcategoryname,
                      decoration: InputDecoration(
                        hintText: "Name of Subcategory",
                        suffixIcon: Icon(Iconsax.link),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                              subcategorycontroller.setCategoryValue(selectedOption);
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

                    TextButton(
                      onPressed: () => subcategorycontroller.uploadsubCategory(),
                      child: Container(
                        padding: EdgeInsets.all(17),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: TSizes.defaultSpace * 6,
                        child: Text("Select Image for upload"),
                      ),
                    ),
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
