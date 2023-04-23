import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/helper/size.dart';
import 'package:harbour_ecommerce/helper/text_style.dart';

import 'colors.dart';

Widget moreDetailsTextForm(BuildContext context, TextEditingController controller) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: AppSize.heightDivide(context, 100),
    ),
    height: AppSize.heightDivide(context, 7.1428),
    width: AppSize.widthMultiply(context, 1),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), color: AppColor.gF5F5F5),
    child: TextFormField(
      controller: controller,
      style: AppText.montserrat40012pxb000000,
      maxLines: 7,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: AppSize.heightDivide(context, 150),
          horizontal: AppSize.widthDivide(context, 50),
        ),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.transparent,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.transparent,
            )),
      ),
    ),
  );
}

Widget contactUsTextForm(
    BuildContext context, String title, double height, int maxLine) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: AppText.montserrat60014pxb000000,
      ),
      Container(
        margin:
            EdgeInsets.symmetric(vertical: AppSize.heightDivide(context, 100)),
        height: AppSize.heightDivide(context, height),
        width: AppSize.widthMultiply(context, 1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColor.oFFB319,
              width: 0.5,
            )),
        child: TextFormField(
          style: AppText.montserrat50014pxg9E9E9E,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
          ),
          maxLines: maxLine,
        ),
      ),
    ],
  );
}
