import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/layouts/grid_layout.dart';
import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
import 'package:sport_shoes_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:sport_shoes_store/features/shop/controllers/product/all_product_controller.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/cloud_helper_futions.dart';

import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../models/product_model.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen(
      {super.key, required this.title, this.query, this.futureMethod});
  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: const KAppbar(
        title: Text('Popular Products'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: FutureBuilder(
                future: futureMethod ?? controller.fetchProductsByQuery(query!),
                builder: (context, snapshot) {
                  const loader = VerticalProductShimmer();
                  final widget = KCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);

                  if (widget != null) return widget;

                  final products = snapshot.data!;

                  return SortableProducts(
                    products: products,
                  );
                })),
      ),
    );
  }
}
