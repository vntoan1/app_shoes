import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/features/authentication/controllers/login/login_controller.dart';
import 'package:sport_shoes_store/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:sport_shoes_store/utils/validators/validation.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../signup/signup.dart';

class LoginFrom extends StatelessWidget {
  const LoginFrom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _keyForm = GlobalKey<FormState>();
    return Form(
      key: _keyForm,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: TextString.email),
            ),
            const SizedBox(
              height: Sizes.spaceBtwInoutFields,
            ),
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => Validator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    labelText: TextString.password,
                    prefixIcon: const Icon(Icons.remove_red_eye),
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined))),
              ),
            ),
            const SizedBox(
              height: Sizes.spaceBtwInoutFields / 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                    const Text(TextString.rememberMe),
                  ],
                ),
                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: const Text(TextString.forgetPassword))
              ],
            ),
            const SizedBox(
              height: Sizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text(TextString.signIn),
              ),
            ),
            const SizedBox(
              height: Sizes.spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const SignUpScreen()),
                child: const Text(TextString.createAccount),
              ),
            ),
            const SizedBox(
              height: Sizes.spaceBtwSections,
            )
          ],
        ),
      ),
    );
  }
}
