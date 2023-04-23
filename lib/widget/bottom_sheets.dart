import 'package:flutter/material.dart';

import '../helper/button.dart';
import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';

Widget botttomSheetWidget(BuildContext context, Function price, Function call) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: AppSize.widthDivide(context, 25),
      vertical: AppSize.heightDivide(context, 100),
    ),
    height: AppSize.heightDivide(context, 9.0909),
    width: AppSize.widthMultiply(context, 1),
    color: AppColor.gF2F2F2,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '40',
              style: AppText.montserrat60020pxb000000,
            ),
            SizedMedia.heightDivide(context, 200),
            InkWell(
              onTap: () {
                price();
              },
              child: AppText.gradientFFB319wo100nFF8A00wo100(
                  'view price details', 12, FontWeight.w700),
            ),
          ],
        ),
        button176(context, () {
          call();
        })
      ],
    ),
  );
}
