import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/products/sortable/sortable_products.dart';
import 'package:ecommerce/features/shop/controllers/product/brand_controller.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/features/shop/screens/brand/brand_card.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/vertical_product_shimmer.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;

    return Scaffold(
      appBar: TAppBar(title: Text(brand.name)),
      body: SingleChildScrollView(
        child: Padding(padding: 
        EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            // Brand Detail 
            TBrandCard(showBorder: true, brand: brand,),
            SizedBox(height: TSizes.spaceBtwSections,),

            FutureBuilder(
              future: controller.getBrandProducts(brandId: brand.id),
              builder: (context, snapshot) {

                // Handle loader, no record 
                const loader = TVerticalProductShimmer();
                final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                if(widget != null) return widget;

                // Record found 
                final brandProducts = snapshot.data!;

                return TSortableProducts(products: brandProducts,);
              }
            ),
          ],
        ),
        ),
      ),
    );
  }
}