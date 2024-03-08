import 'package:ecommerce/common/styles/rounded_container.dart';
import 'package:ecommerce/common/widgets/images/t_circular_image.dart';
import 'package:ecommerce/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    this.onTap,
    required this.showBorder, required this.brand,
  });

  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
    onTap: onTap,
    child: TRoundedContainer(
      showBorder: showBorder,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(TSizes.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: TCircularImage(
              isNetworkImage: true,
              image: brand.image,
              backgroundColor: Colors.transparent,
              overlayColor: isDark ? TColors.white : TColors.black,
              ),
          ),
            const SizedBox(width: TSizes.spaceBtwItems / 2,),
                  
            // Text 
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [              
                  TBrandTitleWithVerifiedIcon(title: brand.name, brandTextSize: TextSizes.large,),
                  Text(
                    '${brand.productsCount ?? 0} products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                                  
                ],
              ),
            )
        ],
      ),
    ),
                  );
  }
}

