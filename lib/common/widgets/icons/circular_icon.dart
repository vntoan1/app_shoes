import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = Sizes.ld,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });
  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor != null
          ? backgroundColor!
          : dark ? ColorApp.black.withOpacity(0.9) : ColorApp.bg.withOpacity(0.9)
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size,),
      ),
    );
  }
}
