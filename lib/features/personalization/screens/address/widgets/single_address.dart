import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:sport_shoes_store/features/personalization/controllers/address_controller.dart';
import 'package:sport_shoes_store/features/personalization/models/address_model.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.addressModel, required this.onTap});

  final AddressModel addressModel;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = AddressController.instance;
    return Obx(
      (){
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == addressModel.id;
        return InkWell(
          onTap: onTap,
          child: RoundedContainer(
            width: double.infinity,
            showBorder: true,
            padding: const EdgeInsets.all(Sizes.md),
            backgroundColor: selectedAddress
                ? ColorApp.blue02.withOpacity(0.5)
                : Colors.transparent,
            borderColor: selectedAddress
                ? Colors.transparent
                : dark
                ? ColorApp.darkGrey
                : ColorApp.grey,
            margin: const EdgeInsets.only(bottom: Sizes.spaceBtwItems),
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    selectedAddress ? Icons.verified : null,
                    color: selectedAddress
                        ? dark
                        ? ColorApp.light
                        : ColorApp.black
                        : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addressModel.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: Sizes.sm / 2,),
                    Text(addressModel.formattedPhoneNo, maxLines: 1, overflow: TextOverflow.ellipsis,),
                    const SizedBox(height: Sizes.sm / 2,),
                    Text(addressModel.toString(), softWrap: true,),
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
