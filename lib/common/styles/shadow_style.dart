import 'package:flutter/cupertino.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';

class ShadowStyle{
  static final verticalProductShadow = BoxShadow(
    color: ColorApp.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );

  static final horizontalProductShadow = BoxShadow(
      color: ColorApp.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2)
  );
}