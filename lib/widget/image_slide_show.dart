import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';


List<Map<String, dynamic>> mapList = [
  {
    'image': 'images/bags.webp',
    'text': 'New Collection',
  },
  {
    'image': 'images/bag.jpg',
    'text': 'New Collection',
  }
];

Widget imageSlider(BuildContext context) {
  return ImageSlideshow(
    height: AppSize.heightDivide(context, 1.8181),
    width: AppSize.widthMultiply(context, 1),
    initialPage: 0,
    children: mapList.map((e) {
      return Container(
          height: AppSize.heightDivide(context, 1.8181),
          width: AppSize.widthMultiply(context, 1),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(e['image']), fit: BoxFit.fill)),
          child: Container(
            height: AppSize.heightDivide(context, 1.8181),
            width: AppSize.widthMultiply(context, 1),
            color: AppColor.b000000w20,
            child: Center(
              child: Text(
                e['text'].toUpperCase(),
                style: AppText.montserrat70020pxwFFFFFF,
              ),
            ),
          ));
    }).toList(),
  );
}
