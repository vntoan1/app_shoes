import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/features/authentication/controllers/signup/signup_controller.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper.dart';

class TermsAndConditionCheckbox extends StatelessWidget {
  const TermsAndConditionCheckbox({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = SignupController.instance;
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value,
            ),
          ),
        ),
        const SizedBox(width: Sizes.spaceBtwItems),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '${TextString.iAgreeTo} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: '${TextString.privacyPolicy} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                decoration: TextDecoration.underline,
                color: dark ? ColorApp.bg : ColorApp.blue02,
                decorationColor: dark ? ColorApp.bg : ColorApp.blue02,
              )),
          TextSpan(
              text: '${TextString.and} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: TextString.termsOfUse,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                decoration: TextDecoration.underline,
                color: dark ? ColorApp.bg : ColorApp.blue02,
                decorationColor: dark ? ColorApp.bg : ColorApp.blue02,
              )),
        ]))
      ],
    );
  }
}