import 'package:flutter/material.dart';

import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';

Widget categoriesListViewBox({
      required BuildContext context,
      required String categoryName,
      required String imageUrl
    }) {
  return Container(
    height: AppSize.heightDivide(context, 11),
    width: AppSize.widthDivide(context, 5.2173),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
       ),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: AppSize.widthDivide(context, 50)),
          height: AppSize.heightDivide(context, 12.0627),
          width: AppSize.widthDivide(context, 5.2173),
          decoration: BoxDecoration(
              color: AppColor.b000000w10,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover)),
        ),
        Text(categoryName, style: AppText.montserrat50010pxb000000w85,)
      ],
    ),
  );
}
