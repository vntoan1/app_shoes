import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
import 'package:sport_shoes_store/features/personalization/controllers/address_controller.dart';
import 'package:sport_shoes_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/cloud_helper_futions.dart';

import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorApp.blue02,
        child: const Icon(Icons.add, color: ColorApp.bg,),
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
      ),
      appBar: KAppbar(
        showBackArrow: true,
        title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Obx(
              () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddresses(),
              builder: (context, snapshot) {
                final response = KCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                if(response != null) return response;

                final address = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: address.length,
                  itemBuilder: (context, index) => SingleAddress(
                    addressModel: address[index],
                    onTap: () => controller.selectAddress(address[index]),
                  ),
                );
              },
            ),
          )
        ),
      ),
    );
  }
}
