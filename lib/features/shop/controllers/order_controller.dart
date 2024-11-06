import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/loader/loaders.dart';
import 'package:sport_shoes_store/data/repositories/authentication_repository.dart';
import 'package:sport_shoes_store/features/authentication/screens/signup/success_screen.dart';
import 'package:sport_shoes_store/features/personalization/controllers/address_controller.dart';
import 'package:sport_shoes_store/features/shop/controllers/cart_controller.dart';
import 'package:sport_shoes_store/features/shop/controllers/checkout_controller.dart';
import 'package:sport_shoes_store/features/shop/models/order_model.dart';
import 'package:sport_shoes_store/navigation_menu.dart';
import 'package:sport_shoes_store/utils/constants/enums.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/popups/full_screen_loader.dart';

import '../../../data/repositories/order_repo.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepo());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrder();
      return userOrders;
    } catch (e) {
      Loaders.warningSnackBar(title: 'Ohhhh', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Processing your order', Images.onBoardingImage3);

      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      // add details
      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        // set date as needed
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      // save
      await orderRepository.saveOrder(order, userId);

      //update
      cartController.clearCart();

      Get.offAll(SuccessScreen(
        image: Images.onBoardingImage3,
        title: 'Payment ...',
        subTitle: 'Your item ...',
        onPressed: () => Get.offAll(() => const NavigationMenu()),
      ));
    } catch (e) {
      Loaders.errorSnackBar(title: 'oh ...', message: e.toString());
    }
  }
}
