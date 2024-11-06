import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/features/authentication/controllers/login/login_controller.dart';
import 'package:sport_shoes_store/features/authentication/screens/signup/signup.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
//  Widget này chứa các nút cho việc đăng nhập qua mạng xã hội.
class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController()); // Tạo và quản lý LoginController.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container( //Chỉnh sửa các nút trong Containerđể thêm đường viền và làm tròn.
          decoration: BoxDecoration(
              border: Border.all(color: ColorApp.grey82),
              borderRadius: BorderRadius.circular(100)
          ),
          child: IconButton(
            onPressed: () => controller.googleSignIn(), //Xử lý sự kiện onPressedcho nút Google để gọi hàm googleSignIn.
            icon: const Image(
              width: Sizes.iconMd,
              height: Sizes.iconMd,
              image: AssetImage(Images.google),
            ),
          ),
        ),
        const SizedBox(width: Sizes.spaceBtwItems,),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: ColorApp.grey82),
              borderRadius: BorderRadius.circular(100)
          ),
          child: IconButton(
            onPressed: (){},
            icon: const Image(
              width: Sizes.iconMd,
              height: Sizes.iconMd,
              image: AssetImage(Images.facebook),
            ),
          ),
        ),
      ],
    );
  }
}