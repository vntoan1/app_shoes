
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../custom_shapes/containers/rounded_container.dart';

class CouponCode extends StatelessWidget {
  const CouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return RoundedContainer(
      showBorder: true,
      backgroundColor: dark ? ColorApp.dark : ColorApp.white,
      padding: const EdgeInsets.only(
          top: Sizes.sm,
          bottom: Sizes.sm,
          right: Sizes.sm,
          left: Sizes.sm),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
              width: 80,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: dark ? ColorApp.bg.withOpacity(0.5) : ColorApp.dark.withOpacity(0.5),
                    backgroundColor: ColorApp.grey.withOpacity(0.8),
                    side: BorderSide(color: ColorApp.grey.withOpacity(0.4)),
                  ),
                  child: const Text('Apply'))
          )
        ],
      ),
    );
  }
}