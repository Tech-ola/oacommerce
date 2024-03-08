import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerce/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce/features/shop/screens/checkout/checkout.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall,)),

    body: 
    Obx(
      () {
        // Nothing found widget 
        final emptyWidget = Column(
          children: [
             Image(image: AssetImage(TImages.empty)),
            TAnimationLoaderWidget(text: 'Whoops! Cart is Empty', animation: TImages.lightAppLogo,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
            ),
          ],
        );


        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: 
                  TCartItems(),
                  
                  ),
          );
        }
      }
    ),
 
//  checkut button  
    bottomNavigationBar: controller.cartItems.isEmpty ? const SizedBox() : Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: ElevatedButton(onPressed: () => Get.to(() => const CheckoutScreen()), child:  Obx(() => Text('Checkout \₦${controller.totalCartPrice.value}')),)),
    
    );
  }
}
