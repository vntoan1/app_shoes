import 'package:flutter/material.dart';
import 'package:sport_shoes_store/common/widgets/heading/section_heading.dart';
import 'package:sport_shoes_store/features/personalization/controllers/address_controller.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Shopping Address',
          buttonTitle: 'Chane',
          onPressed: () => addressController.selectNewAddressPopup(context),
        ),
        addressController.selectedAddress.value.id.isNotEmpty ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Coding with KD', style: Theme.of(context).textTheme.bodyLarge,),
            const SizedBox(height: Sizes.spaceBtwItems/2,),
            Row(
              children: [
                Icon(Icons.phone, color: ColorApp.grey, size: 16,),
                SizedBox(width: Sizes.spaceBtwItems,),
                Text('+84 0328327293', style: Theme.of(context).textTheme.bodyMedium,)
              ],
            ),
            const SizedBox(height: Sizes.spaceBtwItems/2,),
            Row(
              children: [
                Icon(Icons.person, color: ColorApp.grey, size: 16,),
                SizedBox(width: Sizes.spaceBtwItems,),
                Expanded(child: Text('LKD, +84 0328327293', style: Theme.of(context).textTheme.bodyMedium,softWrap: true,))
              ],
            ),
          ],
        ) : Text('Select Address', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
