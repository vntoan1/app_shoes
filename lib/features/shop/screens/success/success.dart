import 'package:flutter/material.dart';
import 'package:sport_shoes_store/common/styles/spacing_styles.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/constants/text_strings.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});
  final String image, title, subTitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              Image(image: AssetImage(image), width: HelperFunctions.screenWidth() * 0.6,),
              const SizedBox(height: Sizes.spaceBtwSections,),
              Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: Sizes.spaceBtwItems,),
              Text(subTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: Sizes.spaceBtwSections,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(TextString.continues),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
