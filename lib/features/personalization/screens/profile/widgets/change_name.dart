import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/constants/text_strings.dart';
import 'package:sport_shoes_store/utils/validators/validation.dart';

import '../controller/update_name_controller.dart';
class ChangeName extends StatefulWidget {
  const ChangeName({super.key});

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: KAppbar(
        showBackArrow: true,
        title: Text('Change Name', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User real name for easy verification...', style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: Sizes.spaceBtwSections,),
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => Validator.validateEmptyText('first name', value),
                    expands: false,
                    decoration: const InputDecoration(labelText: TextString.firstName, prefixIcon: Icon(Icons.person)),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => Validator.validateEmptyText('last name', value),
                    expands: false,
                    decoration: const InputDecoration(labelText: TextString.lastName, prefixIcon: Icon(Icons.person)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwItems,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
