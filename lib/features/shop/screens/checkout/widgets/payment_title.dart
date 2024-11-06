import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:sport_shoes_store/features/shop/controllers/checkout_controller.dart';
import 'package:sport_shoes_store/features/shop/models/payment_method_model.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';
class PaymentTile extends StatelessWidget {
  const PaymentTile({super.key, required this.paymentMethodModel});

  final PaymentMethodModel paymentMethodModel;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethodModel;
        Get.back();
      },
      leading: RoundedContainer(
        width: 60,
        height: 60,
        backgroundColor: HelperFunctions.isDarkMode(context) ? ColorApp.light : Colors.white,
        padding: const EdgeInsets.all(Sizes.sm),
        child: Image(image: AssetImage(paymentMethodModel.image), fit: BoxFit.contain),
      ),
      title: Text(paymentMethodModel.name),
      trailing: const Icon(Icons.arrow_forward),
    );
  }
}
