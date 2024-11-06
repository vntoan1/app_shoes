import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sport_shoes_store/features/shop/controllers/product/all_product_controller.dart';
import 'package:sport_shoes_store/features/shop/models/product_model.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class SortableProducts extends StatelessWidget {
  const   SortableProducts({
    super.key, required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(products);
    return Column(
      children: [
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Icons.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value) {
            // sort products based on the selected option
            controller.sortProducts(value!);
          },
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest']
              .map((option) => DropdownMenuItem(
            value: option,
            child: Text(option),
          ))
              .toList(),
        ),
        const SizedBox(height: Sizes.spaceBtwSections,),
        Obx(()=> GridLayout(itemCount: controller.products.length, itemBuilder: (p0, index) => ProductCardVertical(productModel: controller.products[index],),))
      ],
    );
  }
}