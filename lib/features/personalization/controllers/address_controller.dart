import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:sport_shoes_store/common/widgets/heading/section_heading.dart';
import 'package:sport_shoes_store/common/widgets/loader/loaders.dart';
import 'package:sport_shoes_store/data/repositories/address_repository.dart';
import 'package:sport_shoes_store/features/authentication/controllers/signup/network_manager.dart';
import 'package:sport_shoes_store/features/personalization/models/address_model.dart';
import 'package:sport_shoes_store/features/personalization/screens/address/add_new_address.dart';
import 'package:sport_shoes_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/cloud_helper_futions.dart';
import 'package:sport_shoes_store/utils/popups/full_screen_loader.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();
  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepo = Get.put(AddressRepository());

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepo.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel addressModel) async {
    try {
      Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: const Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0, // Remove the shadow
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      // clear
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepo.updateSelectedField(selectedAddress.value.id, false);
      }

      // assign selected address
      addressModel.selectedAddress = true;
      selectedAddress.value = addressModel;

      // set the selected field to true for the newly selected address
      await addressRepo.updateSelectedField(selectedAddress.value.id, true);
      Get.back();
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error .....', message: e.toString());
    }
  }

  Future addNewAddresses() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Storing Address...', Images.onBoardingImage3);

      final isConnect = await NetworkManager.instance.isConnected();
      if (!isConnect) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      //save data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepo.addAddress(address);

      // update selected address status
      address.id = id;
      await selectedAddress(address);

      FullScreenLoader.stopLoading();

      Loaders.successSnackBar(
          title: 'Gooddd...', message: 'You address has been ...');

      refreshData.toggle();

      resetFromFields();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Error .....', message: e.toString());
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(Sizes.ld),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              title: 'Select Address',
              showActionButton: false,
            ),
            FutureBuilder(
              future: getAllUserAddresses(),
              builder: (context, snapshot) {
                final response = KCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => SingleAddress(
                    addressModel: snapshot.data![index],
                    onTap: () async {
                      await selectedAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: Sizes.defaultSpace * 2,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const AddNewAddressScreen()),
                child: const Text('Add new address'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetFromFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
