import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';

import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';

Widget instructionWidget(
    BuildContext context, var icon, String title, String subtitle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      DashedCircle(
        strokeWidth: 1,
        dashes: 15,
        gapSize: 4,
        color: AppColor.b403C3C,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 26,
          child: Icon(
            icon,
            color: AppColor.b403C3C,
            size: AppSize.heightDivide(context, 27),
          ),
        ),
      ),
      SizedBox(
        height: AppSize.heightDivide(context, 17.7777),
        width: AppSize.widthMultiply(context, 0.67),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: AppText.montserrat60012pxb403C3C,
            ),
            Text(
              subtitle,
              style: AppText.montserrat40008pxb000000w51,
              maxLines: 3,
            )
          ],
        ),
      )
    ],
  );
}
