import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/heading/section_heading.dart';
import 'package:sport_shoes_store/features/shop/models/payment_method_model.dart';
import 'package:sport_shoes_store/features/shop/screens/checkout/widgets/payment_title.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';

class CheckoutController extends GetxController{
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Paypal', image: Images.lightAppLogo);
    super.onInit();
  }
  Future<dynamic> selectPaymentMethod(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(Sizes.iconLg),
            child: Column(
              children: [
                const SectionHeading(title: 'Select Payment ...', showActionButton: true,),
                const SizedBox(height: Sizes.spaceBtwSections,),
                PaymentTile(paymentMethodModel: PaymentMethodModel(name: 'Paypal', image: Images.lightAppLogo)),
                const SizedBox(height: Sizes.spaceBtwSections/2,),
                PaymentTile(paymentMethodModel: PaymentMethodModel(name: 'Google', image: Images.lightAppLogo)),
                const SizedBox(height: Sizes.spaceBtwSections/2,),
                PaymentTile(paymentMethodModel: PaymentMethodModel(name: 'ZaloPay', image: Images.lightAppLogo)),
                const SizedBox(height: Sizes.spaceBtwSections/2,),
                PaymentTile(paymentMethodModel: PaymentMethodModel(name: 'Momo', image: Images.lightAppLogo)),
              ],
            ),
          ),
        )
    );
  }
}