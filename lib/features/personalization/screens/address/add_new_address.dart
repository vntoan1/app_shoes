import 'package:flutter/material.dart';
import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
import 'package:sport_shoes_store/features/personalization/controllers/address_controller.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/validators/validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: KAppbar(
        showBackArrow: true,
        title: Text('Add new Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) => Validator.validateEmptyText('Name', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person), labelText: 'Name'),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInoutFields,
                ),
                TextFormField(
                  controller: controller.phoneNumber,
                  // validator: (value) => Validator.validatePhoneNumber('PhoneNumber'),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone), labelText: 'Phone'),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInoutFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) => Validator.validateEmptyText('Street', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.streetview),
                            labelText: 'Street'),
                      ),
                    ),
                    const SizedBox(
                      width: Sizes.spaceBtwInoutFields,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) => Validator.validateEmptyText('Postal Code', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.post_add), labelText: 'Pos'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInoutFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) => Validator.validateEmptyText('City', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.location_city),
                            labelText: 'City'),
                      ),
                    ),
                    const SizedBox(
                      width: Sizes.spaceBtwInoutFields,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) => Validator.validateEmptyText('State', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.real_estate_agent),
                            labelText: 'State'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInoutFields,
                ),
                TextFormField(
                  controller: controller.country,
                  validator: (value) => Validator.validateEmptyText('Country', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.language), labelText: 'Country'),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInoutFields,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.addNewAddresses(),
                    child: const Text('Save'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
