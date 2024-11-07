import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/styles/spacing_styles.dart';
import 'package:sport_shoes_store/features/authentication/screens/login/widgets/from_divider.dart';
import 'package:sport_shoes_store/features/authentication/screens/login/widgets/login_form.dart';
import 'package:sport_shoes_store/features/authentication/screens/login/widgets/login_header.dart';
import 'package:sport_shoes_store/features/authentication/screens/login/widgets/social_buttons.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              const LoginHeader(),
              const LoginFrom(),
              FormDivider(dividerText: TextString.orSignInWith.capitalize!),
              const SizedBox(height: Sizes.spaceBtwSections,),
              const SocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
