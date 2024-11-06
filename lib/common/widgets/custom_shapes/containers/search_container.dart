import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utils.dart';
import '../../../../utils/helpers/helper.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.text,
    this.showBackground = true,
    this.showBorder = true,
    this.icon = Icons.search,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: DeviceUtils.getScreenWith(context),
          padding: const EdgeInsets.all(Sizes.md),
          decoration: BoxDecoration(
              color: showBackground
                  ? dark
                      ? ColorApp.dark
                      : ColorApp.light
                  : ColorApp.grey82,
              borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
              border: showBorder ? Border.all(color: ColorApp.grey82) : null),
          child: Row(
            children: [
              Icon(
                icon,
                color: ColorApp.darkGrey,
              ),
              const SizedBox(
                width: Sizes.spaceBtwItems,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
