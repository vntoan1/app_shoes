import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:sport_shoes_store/features/authentication/screens/home/home.dart';
import 'package:sport_shoes_store/features/authentication/screens/signup/vefify_email.dart';
import 'package:sport_shoes_store/features/authentication/screens/signup/widgets/terms_and_condition_checkbox.dart';
import 'package:sport_shoes_store/utils/validators/validation.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper.dart';

class SignupFrom extends StatelessWidget {
  const SignupFrom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      Validator.validateEmptyText('First Name', value),
                  decoration: const InputDecoration(
                      labelText: TextString.firstName,
                      prefixIcon: Icon(Icons.person)),
                ),
              ),
              const SizedBox(
                width: Sizes.spaceBtwInoutFields,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      Validator.validateEmptyText('Last Name', value),
                  decoration: const InputDecoration(
                      labelText: TextString.lastName,
                      prefixIcon: Icon(Icons.person)),
                ),
              ),
            ],
          ),
          const SizedBox(height: Sizes.spaceBtwInoutFields),
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                Validator.validateEmptyText('User Name', value),
            decoration: const InputDecoration(
                labelText: TextString.username, prefixIcon: Icon(Icons.person)),
          ),
          const SizedBox(height: Sizes.spaceBtwInoutFields),
          TextFormField(
            controller: controller.email,
            validator: (value) => Validator.validateEmail(value),
            decoration: const InputDecoration(
                labelText: TextString.email, prefixIcon: Icon(Icons.person)),
          ),
          const SizedBox(height: Sizes.spaceBtwInoutFields),
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => Validator.validatePhoneNumber(value),
            decoration: const InputDecoration(
                labelText: TextString.phone, prefixIcon: Icon(Icons.person)),
          ),
          const SizedBox(height: Sizes.spaceBtwInoutFields),
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => Validator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                  labelText: TextString.password,
                  prefixIcon: const Icon(Icons.remove_red_eye),
                  suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                      icon: Icon(controller.hidePassword.value ? Icons.remove_red_eye : Icons.remove_red_eye_outlined)
                  )),
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwSections),
          const TermsAndConditionCheckbox(),
          const SizedBox(height: Sizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => controller.singUp(),
                child: const Text(TextString.createAccount)),
          )
        ],
      ),
    );
  }
}

