import 'package:ecommerce/common/widgets/images/t_circular_image.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    final networkImage = controller.user.value.profilePicture;
        final image = networkImage.isNotEmpty ? networkImage : TImages.user;
    return Obx(
      () => ListTile(
       leading:  TCircularImage(
         image: image, width: 50, height: 50, padding: 0, isNetworkImage: true,),
         title: Text(controller.user.value.fullName, style:  Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),),
         subtitle:  Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),),
         trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: TColors.white,),),
                      ),
    );
  }
}