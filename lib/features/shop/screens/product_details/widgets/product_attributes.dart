import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/common/widgets/chips/choice_chip.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/product/variation_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductModel product;
  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = THelperFunctions.isDarkMode(context);
    
    return Obx(
      () => Column(
        children: [
          if(controller.selectedVariation.value.id.isNotEmpty)
          // Selected attributes 
          TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.md),
            backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
    
            child: Column(
              children: [
                // Tilte Price  
                Row(
                  children: [
                    const TSectionHeading(title: 'Variation', showActionButton: false,),
                    const SizedBox(width: TSizes.spaceBtwItems,),
    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(
                      children: [
                      const TProductTitleText(title: 'Price :', smallSize: true,),
    
                            // Actual price 
                          if(controller.selectedVariation.value.salePrice > 0)
                          Text('\$${controller.selectedVariation.value.price}',
                          style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
                          ),
                          
                          const SizedBox(width: TSizes.spaceBtwItems,),
                          
                          // Sale Price 
                          TProductPriceText(price: controller.getVariationPrice()),
    
                      ],
                    ),
    
                    // Stock 
                    Row(
                      children: [
                        const TProductTitleText(title: 'Stock :', smallSize: true,),
                        Text(controller.variationStockStatus.value, style: Theme.of(context).textTheme.titleMedium,),
                      ],
                    )
                
                      ],
                    ),
                  ],
                ),
    
                // Variation Description 
               TProductTitleText(title: controller.selectedVariation.value.description ?? '',
                smallSize: true,
                maxLines: 4,
                )
              ],
            ),
          ),
    
          const SizedBox(height: TSizes.spaceBtwItems,),
    
          // Attributes 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
            .map((attribute) =>  Column(
                crossAxisAlignment: CrossAxisAlignment.start,          
                children: [
                   TSectionHeading(title: attribute.name ?? '', showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems / 2,),
                  
                Obx(
                  () => Wrap(
                    spacing: 8,
                    children: attribute.values!.map((attributeValue){
                      final isSelected = controller.selectedAttributes[attribute.name] == attributeValue;
                      final available = controller.getAttributesAvailabilityInVariation(product.productVariations!, attribute.name!).contains(attributeValue);
                      
                      return TChoiceChip(text: attributeValue, selected: isSelected, onSelected: available ? (selected) {
                        if(selected && available){
                          controller.onAttributeSelected(product, attribute.name ?? '', attributeValue);
                        }
                      }: null );
                    }).toList(),
                  ),
                )
    
                ],
              ),)
              .toList(),
            
            
          ),
          
        ],
      ),
    );
  }
}

