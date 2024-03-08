import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class uploadproductImage extends StatelessWidget {
  const uploadproductImage({
    super.key, required this.imagetext, this.onTap,
  });

  final String imagetext;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: TSizes.defaultSpace * 20,
        height: TSizes.defaultSpace * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey,
        ),  
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            Text(imagetext),
            SizedBox(width: 10,),
             Icon(Iconsax.document_upload),
          ],
        ),
      ),
    );
  }
}
