import 'package:get/get.dart';
import 'package:sport_shoes_store/features/authentication/controllers/signup/network_manager.dart';
import 'package:sport_shoes_store/features/personalization/controllers/address_controller.dart';
import 'package:sport_shoes_store/features/shop/controllers/checkout_controller.dart';
import 'package:sport_shoes_store/features/shop/controllers/product/variation_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckoutController());
  }
}