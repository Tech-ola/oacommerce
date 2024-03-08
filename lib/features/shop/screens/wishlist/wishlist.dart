import 'package:ecommerce/common/widgets/appBar/appbar.dart';
import 'package:ecommerce/common/widgets/icon/t_circular_icon.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce/features/shop/controllers/product/favourites_controller.dart';
import 'package:ecommerce/features/shop/screens/home/home.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/vertical_product_shimmer.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoritesController.instance;

    return Scaffold(
      appBar: TAppBar(
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium,),
        // actions: [
        //   TCircularIcon(icon: Iconsax.add, onPressed: () => Get.to(() => const NavigationMenu())),
        // ],
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: 
          // product grid 
          Obx(
                () => FutureBuilder(
                  future: controller.favoriteProducts(),
                  builder: (context, snapshot) {
              
                    // Nothing found 
                    final emptyWidget = GestureDetector(
                      onTap: () => Get.to(() => const NavigationMenu()),
                      child: 
                      Column(
                        children: [
                          Image(image: AssetImage(TImages.empty)),
                          
                          TAnimationLoaderWidget(text: 'Whoops! Wishlist is empty ...', 
                      animation: TImages.empty,
                      showAction: true,
                      actionText: 'Let\'s add some',
                      onActionPressed: () => Get.off(() => const NavigationMenu()),
                      ),
                        ],
                      )
                    );
                    
                    const loader = TVerticalProductShimmer(itemCount: 4,);
                    final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader, nothingFound: emptyWidget);
                    if(widget != null) return widget;
                    
              
                    final products = snapshot.data!;
              
                    return TGridLayout(
                      itemCount: products.length, 
                      itemBuilder: (_,index) => TProductCardVertical(product: products[index],));
                  }
                ),
              )
          
          ),
          ),
    
    );
  }
}