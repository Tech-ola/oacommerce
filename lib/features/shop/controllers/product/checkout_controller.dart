
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/authentication/models/payment_method_model.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(image: TImages.paypal, name: 'Paypal');
    super.onInit();
  }


  Future<dynamic> selectPaymentMethod(BuildContext context){

    return showModalBottomSheet(
      context: context, 
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const TSectionHeading(title: 'Select Payment Method', showActionButton: false,),
               const SizedBox(height: TSizes.spaceBtwSections,),
              TPaymentTile( paymentMethod: PaymentMethodModel( name: 'Paypal', image: TImages.paypal)),
              const SizedBox(height: TSizes.spaceBtwItems/2,),

              TPaymentTile( paymentMethod: PaymentMethodModel( name: 'Google Pay', image: TImages.googlePay)),
              const SizedBox(height: TSizes.spaceBtwItems/2,),

              TPaymentTile( paymentMethod: PaymentMethodModel( name: 'Apple Pay', image: TImages.applePay)),
              const SizedBox(height: TSizes.spaceBtwItems/2,),

              TPaymentTile( paymentMethod: PaymentMethodModel( name: 'Visa', image: TImages.visa)),
              const SizedBox(height: TSizes.spaceBtwItems/2,),

              TPaymentTile( paymentMethod: PaymentMethodModel( name: 'Credit Card', image: TImages.creditCard)),
              const SizedBox(height: TSizes.spaceBtwItems/2,),
              const SizedBox(height: TSizes.spaceBtwSections,),

            ],
          ),
        ),
      )
      
      );
  }

}