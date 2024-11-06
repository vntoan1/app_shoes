import 'package:flutter/material.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/device/device_utils.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';
class KTabBar extends StatelessWidget implements PreferredSizeWidget{
  const KTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? ColorApp.black : ColorApp.bg,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: ColorApp.blue02,
        labelColor: dark ? ColorApp.bg : ColorApp.blue02,
        unselectedLabelColor: ColorApp.darkGrey,
      )
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}
