import 'package:ecommerce/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/text_strings.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasword extends StatelessWidget {
  const ResetPasword({super.key, required this.email});

  final String email;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Image 
              Image(image: const AssetImage(TImages.deliveredEmailIllustration),
              width: THelperFunctions.screenWidth() * 0.6,),

              const SizedBox(height: TSizes.spaceBtwSections,),

              // Title & SubTitle
              Text(email, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),

              const SizedBox(height: TSizes.spaceBtwItems,),

              Text(TTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwItems,),

              Text(TTexts.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              const SizedBox(height: TSizes.spaceBtwItems,),

              // Buttons 
              SizedBox(width: double.infinity, 
              child: ElevatedButton(onPressed: ()=> Get.offAll(() => const LoginScreen()), child: const Text(TTexts.done)),),

              const SizedBox(height: TSizes.spaceBtwItems,),

              SizedBox(width: double.infinity, 
              child: TextButton(onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email), child: const Text(TTexts.resendEmail)),),
            ],
          ),
        ),
      ),
    );
  }
}