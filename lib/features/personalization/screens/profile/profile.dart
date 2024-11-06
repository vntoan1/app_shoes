import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
import 'package:sport_shoes_store/common/widgets/heading/section_heading.dart';
import 'package:sport_shoes_store/common/widgets/images/circular_image.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/shimmer.dart';
import 'package:sport_shoes_store/data/controller/user_controller.dart';
import 'package:sport_shoes_store/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:sport_shoes_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const KAppbar(showBackArrow: true, title: Text('Thông tin cá nhân'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx((){
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty ? networkImage : Images.product1;
                      return controller.imageUploading.value ? const KShimmerEffect( width: 80,height: 80, radius: 80,) : CircularImage(image: image, width: 80,height: 80, isNetworkImage: networkImage.isNotEmpty,);
                    }),
                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text("Change Profile ...."))
                  ],
                ),
              ),
              SizedBox(height: Sizes.spaceBtwItems / 2,),
              Divider(),
              SizedBox(height: Sizes.spaceBtwItems,),
              SectionHeading(title: "Profile Information", showActionButton: false,),
              SizedBox(height: Sizes.spaceBtwItems,),

              ProfileMenu(onPressed: () => Get.to(() => const ChangeName()), title: 'Name', value: controller.user.value.fullName,),
              ProfileMenu(onPressed: () {  }, title: 'Username', value: controller.user.value.username,),

              SizedBox(height: Sizes.spaceBtwItems,),
              const Divider(),
              SizedBox(height: Sizes.spaceBtwItems,),

              SectionHeading(title: 'Personal Information', showActionButton: false,),
              SizedBox(height: Sizes.spaceBtwItems,),

              ProfileMenu(onPressed: () {  }, title: 'User ID', value: controller.user.value.id,),
              ProfileMenu(onPressed: () {  }, title: 'E-mail', value: controller.user.value.email,),
              ProfileMenu(onPressed: () {  }, title: 'Phone Number', value: controller.user.value.phoneNumber,),
              ProfileMenu(onPressed: () {  }, title: 'Gender', value: 'Male',),
              ProfileMenu(onPressed: () {  }, title: 'Date of Birth', value: '10 Oct, 2001',),
              const SizedBox(height: Sizes.spaceBtwItems,),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems,),

              Center(
                child: TextButton(
                  onPressed: (){},
                  child: Text('Close Account', style: TextStyle(color: Colors.red),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

