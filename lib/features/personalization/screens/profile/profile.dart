import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/images/t_circular_image.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:ecommerce/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/popups/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return  Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Profile'),),

      // Body  
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
          children: [
            // Profile picture 
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Obx(() 
                  {
                    final networkImage = controller.user.value.profilePicture;
                    final image = networkImage.isNotEmpty ? networkImage : TImages.user;

                     return controller.imageUploading.value ? const TShimmerEffect(width: 80, height: 80, radius: 80,) : TCircularImage(image: image, width: 80, height: 80, isNetworkImage: networkImage.isNotEmpty,);
                  }
                  ),
                  TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture'))
                ],
              ),
            ),

            // Details 
            const SizedBox(height: TSizes.spaceBtwItems / 2,),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems,),
            const TSectionHeading(title: 'Profile Information', showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItems,),

            TProfileMenu(title: 'Name', value: controller.user.value.fullName, onPressed: () => Get.to(() => const ChangeName()), showIcon: true,),
            TProfileMenu(title: 'Username', value: controller.user.value.username, onPressed: () => Get.back(), showIcon: false,),     

            const SizedBox(height: TSizes.spaceBtwItems,),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems,),

            // Heading personal info   
            TProfileMenu(title: 'User ID', value: controller.user.value.id, onPressed: () => Get.back(), showIcon: false,),
            TProfileMenu(title: 'E-mail', value: controller.user.value.email, onPressed: () => Get.back(), showIcon: false,),   
            TProfileMenu(title: 'Phone Number', value: controller.user.value.phoneNumber, onPressed: () => Get.back(), showIcon: false,),
            TProfileMenu(title: 'Gender', value: 'Male', onPressed: () => Get.back(), showIcon: false,),  
            TProfileMenu(title: 'Date of Birth', value: '10 Oct, 1994', onPressed: () => Get.back(), showIcon: false,),  

          const Divider(),
          const SizedBox(height: TSizes.spaceBtwItems,),

          Center(
            child: TextButton(
              onPressed: () => controller.deleteAccountWarningPopup(),
              child: const Text('Close Account', style: TextStyle(color: Colors.red),),
              ),
          )

          ],
        ),
        
        ),
      ),
    );
  }
}
