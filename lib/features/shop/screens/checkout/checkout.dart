import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/products/cart/coupon_widget.dart';
import 'package:ecommerce/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce/features/shop/controllers/product/order_controller.dart';
import 'package:ecommerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:ecommerce/utils/helpers/pricing_calculator.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, 'US');

    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Order Review', style: Theme.of(context).textTheme.headlineSmall,),),

      body: 
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TCartItems(showAddRemoveButton: false,),
              const SizedBox(height: TSizes.spaceBtwSections,),


              // Coupon 
              const TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections,),

              // Billing Section 
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    // Pricing 
                    TBillingAmountSection(),
                     SizedBox(height: TSizes.spaceBtwItems,),

                    // Divider 
                     Divider(),
                     SizedBox(height: TSizes.spaceBtwItems,),

                    // Payment Methods 
                     TBillingPaymentSection(),
                     SizedBox(height: TSizes.spaceBtwItems,),

                    //  Address 
                    TBillingAddressSection()


                  ],
                ),
              )

            ],
          ),
          ),
      ),

        // Checkout button  
       bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: ElevatedButton(onPressed: 
      subTotal > 0 ? () => orderController.processOrder(totalAmount): () => TLoaders.warningSnackBar(title: 'Empty Cart', message: 'Add items in the cart to proceed.'), 
      child: Text('Checkout \₦$totalAmount)}'),
      
      )),
    

    );
  }
}
