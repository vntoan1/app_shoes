import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_shoes_store/common/widgets/images/circular_image.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key, required this.image, required this.title, this.textColor = ColorApp.bg, this.backgroundColor = ColorApp.bg, this.onTap, this.isNetworkImage = true,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: Sizes.spaceBtwItems),
        child: Column(
          children: [
            CircularImage(
              image: image,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
            ),
            const SizedBox(height: Sizes.spaceBtwItems / 3 ,),
            SizedBox(
              width: 55,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium!.apply(color: backgroundColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}