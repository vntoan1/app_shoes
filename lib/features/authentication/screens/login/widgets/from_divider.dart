import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context); //Kiểm tra chế độ tối
    return Row( // sắp xếp các thành phần con theo chiều ngang.
      mainAxisAlignment: MainAxisAlignment.center,
      //Thuộc tính này căn giữa các phần tử con dọc theo trục chính (trong trường hợp này là trục ngang).
      children: [
        Flexible(
          child: Divider(color: dark ? ColorApp.darkGrey : ColorApp.grey82, thickness: 0.5, indent: 60, endIndent: 5),
        ), // sử dụng toán tử điều kiện để chọn màu. Nếu darklà true, sử dụng ColorApp.darkGrey; nếu không, sử dụng ColorApp.grey82
        Text(dividerText, style: Theme.of(context).textTheme.labelMedium,),// Hiển thị văn bản ở giữa hàng.
        Flexible(
          child: Divider(color: dark ? ColorApp.darkGrey : ColorApp.grey82, thickness: 0.5, indent: 5, endIndent: 60),
        ), //Đặt độ dày của bộ chia thành 0.5.  ,  Chỉ định khoảng cách ở đầu bộ chia (60 pixel),  Chỉ định khoảng cách ở cuối bộ chia (5 pixel).
      ],
    );
  }
}