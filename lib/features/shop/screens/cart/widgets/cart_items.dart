import 'package:ecommerce/common/widgets/products/cart/add_remove_button.dart';
import 'package:ecommerce/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_price_text.dart';
import 'package:ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButton = true,});

  final bool showAddRemoveButton;
  
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(
      () => ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_,__) => const SizedBox(height: TSizes.spaceBtwSections,), itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];

          return  Column(
            children: [
               TCartItem(cartItem: item),
              if(showAddRemoveButton)
              const SizedBox(height: TSizes.spaceBtwItems,),
            
              if(showAddRemoveButton) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Row(
                     children: [
                      // Extra space 
                       SizedBox(width: 70,),
                      // Add remove button 
                      TProductQuantityWithAddRemove(quantity: item.quantity,
                      add: () => cartController.addOneToCart(item),
                      remove: () => cartController.removeOneFromCart(item),),
                     ],
                   ),
                  TProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1)),
                ],
            
              )
            ],
            
          );

        }
          
        )
        
        ),
    );
  }
}