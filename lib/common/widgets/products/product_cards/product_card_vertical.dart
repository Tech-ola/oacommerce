import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/common/styles/shadows.dart';
import 'package:ecommerce/common/widgets/icon/t_circular_icon.dart';
import 'package:ecommerce/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:ecommerce/common/widgets/products/product_cards/add_to_cart_button.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:ecommerce/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/product_details/product_detail.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);

    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetail(product: product,)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
    
            TRoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                   Center(child: TRoundedImage(imageUrl: product.thumbnail, applyImageRadius: true, isNetworkImage: true,)),
    
                  // Sale tag 
                  if(salePercentage != null)
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),),
                    ),
                  ),
    
                  // Favorite Icon
                  Positioned(
                  top: 0,
                  right: 0,
                  child: TFavouriteIcon(productId: product.id,), 
                  ), 
                  
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems/2,),
    
            // Details 
              Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(title: product.title, smallSize: true,),
                  const SizedBox(height: TSizes.spaceBtwItems / 2,),
                  
                  TBrandTitleWithVerifiedIcon(title: product.brand!.name),
                ],
              ),
            ),

            const Spacer(),
    
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price 
                       Flexible(
                         child: Column(
                           children: [

                            if(product.productType == ProductType.single.toString() && product.salePrice > 0)
                              Padding(
                              padding: const EdgeInsets.only(left: TSizes.sm),
                              child: Text(
                                product.price.toString(),
                                style:  Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                              )),

                           
                          //  Price 
                             Padding(
                              padding: const EdgeInsets.only(left: TSizes.sm),
                              child: TProductPriceText(price: controller.getProductPrice(product))),
                           ],
                         ),
                       ),

                    // Add to cart 
                      ProductCardAddToCartButton(product: product),
                    ],
                  )

          ],
        ),
    
        
      ),
    );
  }
}

