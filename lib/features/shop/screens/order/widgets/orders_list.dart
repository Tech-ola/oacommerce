import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerce/features/shop/controllers/product/order_controller.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = THelperFunctions.isDarkMode(context);
    return FutureBuilder(
      future: controller.fetchUserOrders(),

      builder: (_, snapshot) {
        // nothing found widget 
        final emptyWidget = Column(
          children: [
             Image(image: AssetImage(TImages.empty)),
            TAnimationLoaderWidget(text: 'Oops! No Orders Yet!', animation: TImages.onBoardingImage3, showAction: true, actionText: 'Let\'s fill it', 
            onActionPressed: () => Get.off(() => const NavigationMenu()),
            ),
          ],
        );

        // Helper function to handle laoder 
        final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, nothingFound: emptyWidget);
        if(response != null) return response;

        // record found 
        final orders = snapshot.data!;

        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, index) => const SizedBox(height: TSizes.spaceBtwItems,),
          itemBuilder: (_, index) {
          final order = orders[index];

            return TRoundedContainer(
            showBorder: true,
            padding: const EdgeInsets.all(TSizes.md),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: 
            Column(
               mainAxisSize: MainAxisSize.min,
        
              children: [
                Row(
                  children: [
                  //  Icon 
                  const Icon(Iconsax.ship),
                  const SizedBox(width: TSizes.spaceBtwItems / 2,),
        
                  // Status & Date 
                 Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status:'),
                    Text(
                      order.orderStatusText,
                      style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary),
                    ),


                    
                    // Text(order.paymentMethod, style: Theme.of(context).textTheme.headlineSmall,),
                
                 
                  ],
                ),
              ),

        
                  // Icon 
        
                  IconButton(onPressed: () {}, icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm,)),
        
                  ],
                ),
        
                const SizedBox(height: TSizes.spaceBtwItems,),
        
                // Row 2
                Row(
        
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                                //  Icon 
                                const Icon(Iconsax.ship),
                                const SizedBox(width: TSizes.spaceBtwItems / 2,),
                    
                                // Status & Date 
                                Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:  CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order',
                            style:  Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary),
                          ),
                          Text(order.id),
                        ],
                      ),
                                ),
                                ],
                              ),
                    ),
        
                // Second row 
                  Expanded(
                    child: Row(
                    children: [
                    //  Icon 
                    const Icon(Iconsax.calendar),
                    const SizedBox(width: TSizes.spaceBtwItems / 2,),
                  
                    // Status & Date 
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:  CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Date',
                            style:  Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary),
                          ),
                          Text(order.formattedOrderDate),
                        ],
                      ),
                    ),
                    ],
                            ),
                  ),
        
        
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwItems,),

                 Row(
        
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                                //  Icon 
                                const Icon(Iconsax.ship),
                                const SizedBox(width: TSizes.spaceBtwItems / 2,),
                    
                                // Status & Date 
                                Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:  CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product Name',
                            style:  Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary),
                          ),
                           Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: order.items.map((item) => Text('${item.brandName} (${item.quantity.toString()})' ?? "")).toList(),),
                          ],
                        ),
                                ),
                                ],
                              ),
                    ),
        
                // Second row 
                  Expanded(
                    child: Row(
                    children: [
                    //  Icon 
                    const Icon(Iconsax.calendar),
                    const SizedBox(width: TSizes.spaceBtwItems / 2,),
                  
                    // Status & Date 
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:  CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipping Date',
                            style:  Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary),
                          ),
                          Text(order.formattedDeliveryDate),
                        ],
                      ),
                    ),
                    ],
                            ),
                  ),
        
        
                  ],
                )
        
              ],
            ), 
        
          );
          }
          
        );
      }
    );
  }
}