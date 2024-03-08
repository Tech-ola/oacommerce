import 'package:ecommerce/common/widgets/appBar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:ecommerce/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/features/personalization/screens/address/address.dart';
import 'package:ecommerce/features/personalization/screens/profile/profile.dart';
import 'package:ecommerce/features/shop/screens/cart/cart.dart';
import 'package:ecommerce/features/shop/screens/order/order.dart';
import 'package:ecommerce/features/shop/screens/order/widgets/allOrders.dart';
import 'package:ecommerce/features/shop/screens/uploads/brandcategory.dart';
import 'package:ecommerce/features/shop/screens/uploads/productcategory.dart';
import 'package:ecommerce/features/shop/screens/uploads/uploadbanner.dart';
import 'package:ecommerce/features/shop/screens/uploads/uploadbrand.dart';
import 'package:ecommerce/features/shop/screens/uploads/uploadcategory.dart';
import 'package:ecommerce/features/shop/screens/uploads/uploadproducts.dart';
import 'package:ecommerce/features/shop/screens/uploads/uploadproducttes.dart';
import 'package:ecommerce/features/shop/screens/uploads/uploadsubcategory.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header 
            TPrimaryHeaderContainer(
              child:  
              Column(
                children: [
                  TAppBar(
                    title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white,)),),
                    const SizedBox(height: TSizes.spaceBtwSections,),

                    // User profile card 
                     TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                     
                    const SizedBox(height: TSizes.spaceBtwSections,),
                ],
              )
              ),

            // Body 
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Account settings 
                  const TSectionHeading(title: 'Account Settings', showActionButton: false,),
                   const SizedBox(height: TSizes.spaceBtwItems,),

                   TSettingsMenuTile(icon: Iconsax.safe_home, title: 'My Addresses', subTitle: 'Set shopping delivery address', onTap: () => Get.to(() => const UserAddressScreen()),),
                   TSettingsMenuTile(icon: Iconsax.shopping_cart, title: 'My Cart', subTitle: 'Add, remove products and move to checkout', onTap: () => Get.to(() => const CartScreen()),),
                  // const TSettingsMenuTile(icon: Iconsax.safe_home, title: 'My Addresses', subTitle: 'Set shopping delivery address'),
                   TSettingsMenuTile(icon: Iconsax.bag_tick, title: 'My Orders', subTitle: 'In-progress and Completed Orders', onTap: () => Get.to(() => const OrderScreen()),),
                  const TSettingsMenuTile(icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Withdraw balance to registered bank account'),
                  const TSettingsMenuTile(icon: Iconsax.discount_shape, title: 'My Coupons', subTitle: 'List of all discounted coupons'),
                  const TSettingsMenuTile(icon: Iconsax.notification, title: 'Notifications', subTitle: 'Set any kind of notification message'),
                  const TSettingsMenuTile(icon: Iconsax.security_card, title: 'Account Privacy', subTitle: 'Manage data usage and connected accounts'),

                  // App settings 
                  // const SizedBox(height: TSizes.spaceBtwSections,),
                  // const TSectionHeading(title: 'App Settings', showActionButton: false,),
                  // const SizedBox(height: TSizes.spaceBtwItems,),
                  // const TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subTitle: 'Upload Data to your Cloud Firebase'),
                  // TSettingsMenuTile(icon: Iconsax.location, title: 'Geolocation', subTitle: 'Set recommendation based on location',
                  // trailing: Switch(value: true, onChanged: (value) {}),
                  // ),

                  // TSettingsMenuTile(icon: Iconsax.security_user, title: 'Safe Mode', subTitle: 'Search result is safe for all ages',
                  // trailing: Switch(value: true, onChanged: (value) {}),
                  // ),

                  // TSettingsMenuTile(icon: Iconsax.image, title: 'HD Image Quality', subTitle: 'Set image quality to be seen',
                  // trailing: Switch(value: false, onChanged: (value) {}),
                  // ),

                  // Uploads 
                    // App settings 
                  const SizedBox(height: TSizes.spaceBtwSections,),
                  const TSectionHeading(title: 'Uploads', showActionButton: false,),
                  Text("Note: This is only visible because application is in test mode. Once in production mode, only authorised personnel would have access", style: TextStyle(fontSize: 12, color: Colors.red),),
                  const SizedBox(height: TSizes.spaceBtwItems,),
                   TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Upload Banners', subTitle: 'Upload the banners on homepage', trailing: const Icon(Iconsax.add_circle), onTap: () => Get.to(() => const UploadBanner()),),

                   TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Upload Brands', subTitle: 'Upload the brands on homepage',
                  trailing: Icon(Iconsax.add_circle), onTap: () => Get.to(() => const UploadBrand()),
                  ),

                  TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Upload Categories', subTitle: 'Upload the categories on homepage',
                  trailing: Icon(Iconsax.add_circle), onTap: () => Get.to(() => const UploadCategory()),
                  ),

                    TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Upload Sub Categories', subTitle: 'Upload the categories on homepage',
                  trailing: Icon(Iconsax.add_circle), onTap: () => Get.to(() => const UploadSubCategory()),
                  ),

                  // TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Upload Products', subTitle: 'Upload the products on homepage',
                  // trailing: Icon(Iconsax.add_circle), onTap: () => Get.to(() => const UploadProducts()),
                  // ),

                  TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Upload Products', subTitle: 'Upload the products on homepage',
                  trailing: Icon(Iconsax.add_circle), onTap: () => Get.to(() => const UploadProductsTest()),
                  ),


                  TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Link Brand to Category', subTitle: 'Upload the products on homepage',
                  trailing: Icon(Iconsax.add_circle), onTap: () => Get.to(() => const BrandCategory()),
                  ),

                  TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Link Product to Category', subTitle: 'Upload the products on homepage',
                  trailing: Icon(Iconsax.add_circle), onTap: () => Get.to(() => const UploadProductCategory()),
                  ),


                TSettingsMenuTile(icon: Iconsax.document_upload, title: 'All Orders', subTitle: 'View all placed orders',
                  trailing: Icon(Iconsax.add_circle), onTap: () => Get.to(() => const AllOrders()),
                  
                  ),


                  // Logout 
                  const SizedBox(height: TSizes.spaceBtwSections,),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: () => AuthenticationRepository.instance.logout(), child: const Text('Logout')),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5,),
                  
                ],
              ),
              )
          ],
        ),
      ),

    );
  }
}
