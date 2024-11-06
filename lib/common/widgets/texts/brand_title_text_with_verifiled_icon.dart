import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_shoes_store/common/widgets/texts/brand_title_text.dart';
import 'package:sport_shoes_store/utils/constants/enums.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class BrandTitleWithVerifiedIcon extends StatelessWidget {
  const BrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
     this.maxLines = 1,
    this.textColor,
    this.iconColor = ColorApp.blue02,
    this.textAlign = TextAlign.center,
     this.brandTextSizes = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: BrandTitle(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSizes,
          ),
        ),
        const SizedBox(
          width: Sizes.xs,
        ),
        Icon(
          Icons.verified,
          color: iconColor,
          size: Sizes.iconsXs,
        )
      ],
    );
  }
}
