import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? Images.onBoardingImage2 : Images.onBoardingImage3),
        ),
        Text(TextString.loginTitle, style: Theme.of(context).textTheme.headlineMedium,),
        const SizedBox(height: Sizes.sm,),
        Text(TextString.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium,),
      ],
    );
  }
}