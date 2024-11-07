import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/features/authentication/screens/login/widgets/from_divider.dart';
import 'package:sport_shoes_store/features/authentication/screens/login/widgets/social_buttons.dart';
import 'package:sport_shoes_store/features/authentication/screens/signup/widgets/signup_from.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/text_strings.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';

import '../../../../utils/constants/sizes.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.signupTitle, style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: Sizes.spaceBtwSections),
              const SignupFrom(),
              const SizedBox(height: Sizes.spaceBtwSections),
              FormDivider(dividerText: TextString.orSignInWith.capitalize!),
              const SizedBox(height: Sizes.spaceBtwSections),
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

