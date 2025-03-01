
import 'package:ecommerce/common/widgets/brands/brand_show_case.dart';
import 'package:ecommerce/features/shop/controllers/product/brand_controller.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/boxes_shimmer.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/list_tile_shimmer.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;

    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {

        // Handle loader 
        const loader = Column(
          children: [
            TListTileShimmer(),
            SizedBox(height: TSizes.spaceBtwItems,),
            TBoxesShimmer(),
            SizedBox(height: TSizes.spaceBtwItems,)
          ],
        );

        final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
        if(widget != null) return widget;

        // Records found 
        final brands = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index){
            final brand  = brands[index];
            return FutureBuilder(
              future: controller.getBrandProducts(brandId: brand.id, limit: 3),
              builder: (context, snapshot) {
                // Handle loader 
                final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                
                if(widget != null) return widget;
                
                // Records found 
                final products = snapshot.data!;

                return TBrandShowcase(brand: brand, images: products.map((e) => e.thumbnail).toList());
              }
            );
          });
      }
    );
  }
}