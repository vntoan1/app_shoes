import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../utils/constants/colors.dart';

class KRatingBarIndicator extends StatelessWidget {
  const KRatingBarIndicator({
    super.key, required this.rating,
  });
  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20,
      unratedColor: ColorApp.grey82,
      itemBuilder: (_, __) => Icon(Icons.star, color: ColorApp.blue02,),
    );
  }
}
