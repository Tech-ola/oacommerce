
import 'package:ecommerce/common/widgets/icon/t_circular_icon.dart';
import 'package:ecommerce/features/shop/controllers/product/favourites_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());
    return Obx(() => TCircularIcon(
      icon: controller.isFavourite(productId) ? Iconsax.heart5 : Iconsax.heart, 
      color: controller.isFavourite(productId) ? TColors.error : null,
      onPressed: () => controller.toggleFavoriteProduct(productId),
      )
      );
  }
}