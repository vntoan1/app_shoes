import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(color: dark ? ColorApp.darkGrey : ColorApp.grey82, thickness: 0.5, indent: 60, endIndent: 5),
        ),
        Text(dividerText, style: Theme.of(context).textTheme.labelMedium,),
        Flexible(
          child: Divider(color: dark ? ColorApp.darkGrey : ColorApp.grey82, thickness: 0.5, indent: 5, endIndent: 60),
        ),
      ],
    );
  }
}