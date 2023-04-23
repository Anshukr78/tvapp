import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/helper/size.dart';
import 'package:harbour_ecommerce/helper/text_style.dart';

import 'colors.dart';

Widget button302(BuildContext context, Function call) {
  return GestureDetector(
    onTap: () {
      call();
    },
    child: Container(
      margin: EdgeInsets.symmetric(
        vertical: AppSize.heightDivide(context, 60),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.widthDivide(context, 15),
      ),
      height: AppSize.heightDivide(context, 11.5942),
      width: AppSize.widthMultiply(context, 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: LinearGradient(
            colors: [
              AppColor.oFFB319,
              AppColor.oFF8A00,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Refer and earn',
            style: AppText.montserrat60016pxb403C3C,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColor.b403C3C,
            size: AppSize.heightDivide(context, 48.4040),
          )
        ],
      ),
    ),
  );
}

Widget bottomSheetButton(BuildContext context, Function call, String text) {
  return InkWell(
    onTap: () {
      call();
    },
    child: Container(
      height: AppSize.heightDivide(context, 14.5148),
      width: AppSize.widthMultiply(context, 1),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColor.oFFB319, AppColor.oFF8A00],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Center(
        child: Text(
          text,
          style: AppText.montserrat60018pxb403C3C,
        ),
      ),
    ),
  );
}

Widget button159(BuildContext context, Function call, String text) {
  return InkWell(
    onTap: () {
      call();
    },
    child: Container(
      height: AppSize.heightDivide(context, 17.7777),
      width: AppSize.widthDivide(context, 2.2641),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
              colors: [AppColor.oFFB319, AppColor.oFF8A00],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Center(
        child: Text(
          text,
          style: AppText.montserrat60018pxb403C3C,
        ),
      ),
    ),
  );
}

Widget button76(BuildContext context, Function call) {
  return InkWell(
    onTap: () {
      call();
    },
    child: Container(
      height: AppSize.heightDivide(context, 25.8064),
      width: AppSize.widthDivide(context, 4.7368),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              width: 1,
              color: AppColor.b403C3C,
              strokeAlign:  BorderSide.strokeAlignInside,
          ),
      ),
      child: Center(
          child: AppText.gradientFFB319wo100nFF8A00wo100(
              'Change', 14, FontWeight.w700)),
    ),
  );
}

Widget button176(BuildContext context, Function call) {
  return InkWell(
    onTap: () {
      call();
    },
    child: Container(
      height: AppSize.heightDivide(context, 13.3333),
      width: AppSize.widthDivide(context, 2.0454),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
              colors: [AppColor.oFFB319, AppColor.oFF8A00],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Center(
        child: Text(
          'Continue',
          style: AppText.montserrat70018pxb403C3C,
        ),
      ),
    ),
  );
}

Widget button49(BuildContext context, Function call) {
  return InkWell(
    onTap: () {
      call();
    },
    child: Container(
      height: AppSize.heightDivide(context, 40),
      width: AppSize.widthDivide(context, 7.3424),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              width: 1,
              color: AppColor.oFF8A00,
              strokeAlign:  BorderSide.strokeAlignInside,
          ),
      ),
      child: Center(
          child: AppText.gradientFFB319wo100nFF8A00wo100(
              'Edit', 12, FontWeight.w700)),
    ),
  );
}
