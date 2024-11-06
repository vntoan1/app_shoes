import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:sport_shoes_store/common/widgets/heading/section_heading.dart';
import 'package:sport_shoes_store/common/widgets/images/circular_image.dart';
import 'package:sport_shoes_store/common/widgets/list_titles/setting_menu_title.dart';
import 'package:sport_shoes_store/features/personalization/screens/address/address.dart';
import 'package:sport_shoes_store/features/shop/screens/order/widgets/order.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';

import '../../../../common/widgets/list_titles/user_profile.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../profile/profile.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  KAppbar(
                    title: Text(
                      'Tài khoản',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: ColorApp.bg),
                    ),
                  ),
                  UserProfile(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  const SectionHeading(
                    title: 'Cài đặt tài khoản',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  SettingMenuTitle(
                    icon: Icons.home,
                    title: 'Địa chỉ của bạn',
                    subTitle: 'Set shopping ...',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  SettingMenuTitle(
                    icon: Icons.card_travel,
                    title: 'Giỏ hàng của bạn',
                    subTitle: 'Set shopping ...',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  SettingMenuTitle(
                      icon: Icons.shopping_bag,
                      title: 'Đơn hàng đã mua',
                      subTitle: 'Set shopping ...',
                      onTap: () => Get.to(() => const OrderScreen())),
                  // const SettingMenuTitle(
                  //     icon: Icons.food_bank,
                  //     title: 'Thanh toán bằng ...',
                  //     subTitle: 'Set shopping ...'),
                  // const SettingMenuTitle(
                  //     icon: Icons.discount,
                  //     title: 'Phiếu giảm giá',
                  //     subTitle: 'Set shopping ...'),
                  // const SettingMenuTitle(
                  //     icon: Icons.notifications,
                  //     title: 'Thông báo',
                  //     subTitle: 'Set shopping ...'),
                  // const SettingMenuTitle(
                  //     icon: Icons.security,
                  //     title: 'Bảo vệ tài khoan',
                  //     subTitle: 'Set shopping ...'),
                  // const SizedBox(
                  //   height: Sizes.spaceBtwSections,
                  // ),
                  // const SectionHeading(
                  //   title: 'App Setting',
                  //   showActionButton: false,
                  // ),
                  // const SizedBox(
                  //   height: Sizes.spaceBtwItems,
                  // ),
                  // SettingMenuTitle(
                  //   icon: Icons.cloud_upload,
                  //   title: 'Load Data',
                  //   subTitle: 'Upload Data to .......',
                  //   trailing: Switch(
                  //     value: true,
                  //     onChanged: (value) {},
                  //   ),
                  // ),
                  // SettingMenuTitle(
                  //   icon: Icons.security_rounded,
                  //   title: 'Safe Mode',
                  //   subTitle: 'Upload Data to .......',
                  //   trailing: Switch(
                  //     value: true,
                  //     onChanged: (value) {},
                  //   ),
                  // ),
                  // SettingMenuTitle(
                  //   icon: Icons.cloud_upload,
                  //   title: 'HD Image',
                  //   subTitle: 'Upload Data to .......',
                  //   trailing: Switch(
                  //     value: true,
                  //     onChanged: (value) {},
                  //   ),
                  // ),
                  const SizedBox(
                    height: 360,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          AuthenticationRepository.instance.logout(),
                      child: const Text('Đăng xuất'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
