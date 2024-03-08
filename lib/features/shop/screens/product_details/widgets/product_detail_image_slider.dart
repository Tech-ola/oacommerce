import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerce/common/widgets/icon/t_circular_icon.dart';
import 'package:ecommerce/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:ecommerce/features/shop/controllers/product/images_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key, required this.product, 
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
        final dark = THelperFunctions.isDarkMode(context);

        final controller = Get.put(ImagesController());
        final images = controller.getAllProductImages(product);

    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            // MAIN lARGE iMAGE 
             SizedBox(height: 400, 
              child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(child: Obx((){
                  final image = controller.selectedProductImage.value;

                  return GestureDetector(
                    onTap: () => controller.showEnlargedImage(image),
                    child: CachedNetworkImage(imageUrl: image,
                    progressIndicatorBuilder: (_, __, downloadProgress) => 
                    CircularProgressIndicator(value: downloadProgress.progress, color: TColors.primary,),
                    ),
                  );
                } ))),
            ),

            // Image Slider 
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                   separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems,),
                    itemBuilder: (_, index) => 
                    Obx((){
                      final imageSelected = controller.selectedProductImage.value == images[index];
                     return TRoundedImage(
                        width: 80,
                        isNetworkImage: true,
                        backgroundColor: dark ? TColors.dark : TColors.white,
                        padding: const EdgeInsets.all(TSizes.sm),
                        onPressed: () => controller.selectedProductImage.value = images[index],
                        imageUrl: images[index],
                         border: Border.all(color: imageSelected ? TColors.primary : Colors.transparent),
                       
                        );
                    }
                    ),),
              ),
            ),

            // Appbar Icons 
             TAppBar(
              showBackArrow: true,
              actions: [
               TFavouriteIcon(productId: product.id,)],
            )

          ],
        ),
      )
      
      );
  }
}