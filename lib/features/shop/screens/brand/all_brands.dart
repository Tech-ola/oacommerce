import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/product/brand_controller.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/features/shop/screens/brand/brand_card.dart';
import 'package:ecommerce/features/shop/screens/brand/brand_products.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/popups/brands_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;

    return Scaffold(
      appBar: const TAppBar(title: Text('Brand'), showBackArrow: true,),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Heading 
             const TSectionHeading(title: 'Brands', showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems,),

              // Brands 
                Obx(
                      (){
                        if(brandController.isLoading.value) return const TBrandsShimmer();

                        if(brandController.allBrands.isEmpty){
                          return Center(
                            child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),
                          );
                        }

                        return  TGridLayout(itemCount: brandController.allBrands.length, mainAxisExtent: 80, itemBuilder: (_, index) 
                      {
                        final brand = brandController.allBrands[index];

                        return TBrandCard(showBorder: true, brand: brand,
                        onTap: () => Get.to(() => BrandProducts(brand: brand,)),
                        );
                      },
                      
                      );
                      },
                    ),


            ],
          ),
          ),
      ),
    );
  }
}