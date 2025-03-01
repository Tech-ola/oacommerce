import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          TSectionHeading(title: 'Shipping Address', buttonTitle: 'Change', onPressed: () => addressController.selectNewAddressPopup(context),),
          addressController.selectedAddress.value.id.isNotEmpty ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Coding with', style: Theme.of(context).textTheme.bodyLarge,),
              const SizedBox(height: TSizes.spaceBtwItems/2,),
              
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey, size:  16,),
                const SizedBox(width: TSizes.spaceBtwItems,),
                Text('+234 814 303 6359', style:  Theme.of(context).textTheme.bodyMedium,),
              ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2,),
              Row(
              children: [
                const Icon(Icons.location_history, color: Colors.grey, size:  16,),
                const SizedBox(width: TSizes.spaceBtwItems,),
                Expanded(child: Text('Ibadan North, Abimbola way, Nigeria', style: Theme.of(context).textTheme.bodyMedium, softWrap: true,)),

            ],
          ),
            ],
          )
          : Text('Select Address', style: Theme.of(context).textTheme.bodyMedium,)

         ],
    );
  }
}