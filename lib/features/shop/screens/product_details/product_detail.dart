import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/raating_share_widget.dart';
import 'package:ecommerce/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});
    
    final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(product : product),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image Slider 
             TProductImageSlider(product: product,),


            // pROUCT DETAILS 
            Padding(
              padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              
              child: Column(
                children: [
                  // Rating  & Share button
                  const TRatingAndShare(),

                  // Price Title, Stock & Brans 
                   TProductMetaData(product: product),

                  // Attributes 
                  if(product.productType == ProductType.variable.toString())  TProductAttributes(product: product,),

                 if(product.productType == ProductType.variable.toString())  const SizedBox(height: TSizes.spaceBtwSections,),

                  // Checkout Button 
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){}, child: const Text('Checkout'))),

                    // Description 
                    const TSectionHeading(title: 'Description', showActionButton: false,),

                    const SizedBox(height: TSizes.spaceBtwItems,),

                     ReadMoreText(product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),

                    // Reviews 
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TSectionHeading(title: 'Reviews(199)', showActionButton: false,),
                        IconButton(onPressed: () => Get.to(() => const ProductReviewScreen()), icon: const Icon(Iconsax.arrow_right_3, size: 10,),)
                        
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections,),


                ],
              ),
              
              
              )

          ],
        ),
      ),
    );
  }
}
