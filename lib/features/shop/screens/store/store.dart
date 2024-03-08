import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/appbar/tabbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/category_controller.dart';
import 'package:ecommerce/features/shop/controllers/product/brand_controller.dart';
import 'package:ecommerce/features/shop/screens/brand/all_brands.dart';
import 'package:ecommerce/features/shop/screens/brand/brand_card.dart';
import 'package:ecommerce/features/shop/screens/brand/brand_products.dart';
import 'package:ecommerce/features/shop/screens/store/widgets/category_tab.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:ecommerce/utils/popups/brands_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());

    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Store', style: Theme.of(context).textTheme.headlineMedium,),
          actions: [
            TCartCounterIcon()
          ],
        ),
    
        body: NestedScrollView(headerSliverBuilder: (_, innerBoxIsScrolled){
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned:  true,
              floating: true,
              backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,
              expandedHeight: 440,
    
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
    
                    // Searchbar 
                    const SizedBox(height: TSizes.spaceBtwItems,),
                    const TSearchContainer(text: 'Enjoy discounts on products!', showBorder: true, showBackground: false, padding: EdgeInsets.zero,),
                    const SizedBox(height: TSizes.spaceBtwSections,),
    
                    // Featured Brands 
                    TSectionHeading(title: 'Featured Brands', onPressed: ()=> Get.to(() => const AllBrandsScreen()),),
                    const SizedBox(height: TSizes.spaceBtwItems / 1.5,),
    
                    Obx(
                      (){
                        if(brandController.isLoading.value) return const TBrandsShimmer();

                        if(brandController.featuredBrands.isEmpty){
                          return Center(
                            child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),
                          );
                        }

                        return  TGridLayout(itemCount: brandController.featuredBrands.length, mainAxisExtent: 80, itemBuilder: (_, index) 
                      {
                        final brand = brandController.featuredBrands[index];

                        return TBrandCard(showBorder: true, brand: brand, onTap: () => Get.to(() => BrandProducts(brand: brand)),);
                      },
                      
                      );
                      },
                    ),
                  ],
                ),
                ),
                
                // Tabs  
                bottom: TTabBar(
                   tabs: categories.map((category) => Tab(child: Text(category.name))).toList()),
            ),
          ];
        },
        
        // Body 
         body: 
          TabBarView(
          children: categories.map((category) => TCategoryTab(category: category)).toList(),
          )
         ),
    
      ),
    );
  }
}
