import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_shoes_store/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
class OverallProductRating extends StatelessWidget {
  const OverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: Text('4.8', style: Theme.of(context).textTheme.displayLarge,)),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              RattingProgressIndicator(value: 1.0, text: '5',),
              RattingProgressIndicator(value: 0.8, text: '4',),
              RattingProgressIndicator(value: 0.6, text: '3',),
              RattingProgressIndicator(value: 0.4, text: '2',),
              RattingProgressIndicator(value: 0.2, text: '1',),
            ],
          ),
        )
      ],
    );
  }
}