import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/data/controller/user_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../image_text_widgets/vertical_image_text.dart';
import '../images/circular_image.dart';
import '../shimmer/shimmer.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
    this.onPressed,
  });

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      onTap: onPressed,
      leading: Obx(() {
        final networkImage = controller.user.value.profilePicture;
        final image = networkImage.isNotEmpty ? networkImage : Images.product1;
        return controller.imageUploading.value
            ? const KShimmerEffect(
                width: 60,
                height: 100,
                radius: 50,
              )
            : Container(
                height: 100,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black,
                ),
                child: CircularImage(
                  image: image,
                  width: 50,
                  height: 90,
                  fit: BoxFit.cover,
                  isNetworkImage: networkImage.isNotEmpty,
                ),
              );
      }),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: ColorApp.bg),
      ),
      subtitle: Text(
        controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: ColorApp.bg),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.edit,
          color: ColorApp.bg,
        ),
      ),
    );
  }
}
