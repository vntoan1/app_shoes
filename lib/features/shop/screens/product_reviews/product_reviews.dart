import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
import 'package:sport_shoes_store/features/shop/screens/product_reviews/widgets/ratting_progress_indicator.dart';
import 'package:sport_shoes_store/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/device/device_utils.dart';

import '../../../../common/widgets/products/ratings/rating_bar_indicator.dart';
class ProductReviewsScreen extends StatefulWidget {
  const ProductReviewsScreen({super.key});

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppbar(
        title: Text('Review & Ratting'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Rattings and reviews are vverfied and are ..."),
              SizedBox(height: Sizes.spaceBtwItems,),
              OverallProductRating(),
              KRatingBarIndicator(rating: 3.5,),
              Text('12,323', style: Theme.of(context).textTheme.bodySmall,),
              const SizedBox(height: Sizes.spaceBtwItems,),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
