import 'package:ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;

    return Column(
      children: [
        // subtotal 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\₦$subTotal', style: Theme.of(context).textTheme.bodyMedium,),            
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2,),

        // Shipping fee 
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\₦${TPricingCalculator.calculateShippingCost(subTotal, 'US')}', style: Theme.of(context).textTheme.labelLarge,),            
          ],
        ),

        // Tax Fee 
         const SizedBox(height: TSizes.spaceBtwItems / 2,),

         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\₦${TPricingCalculator.calculateTax(subTotal, 'US')}', style: Theme.of(context).textTheme.labelLarge,),            
          ],
        ),

         const SizedBox(height: TSizes.spaceBtwItems / 2,),

        // Order Total
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order TOtal', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\₦${TPricingCalculator.calculateTotalPrice(subTotal, 'US')}', style: Theme.of(context).textTheme.titleMedium,),            
          ],
        ),
      ],
    );
  }
}