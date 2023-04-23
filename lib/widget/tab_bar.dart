import 'package:flutter/material.dart';


import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';

Widget searchPageTabBar(BuildContext context) {
  return TabBar(
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.only(right: AppSize.widthDivide(context, 25)),
      indicatorPadding:
          EdgeInsets.only(right: AppSize.widthDivide(context, 25)),
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: AppColor.b000000,
      labelColor: AppColor.b000000,
      unselectedLabelColor: AppColor.b403C3Cw50,
      labelStyle: AppText.montserrat50014pxb000000,
      unselectedLabelStyle: AppText.montserrat50014pxb403C3Cw50,
      tabs: const [
        Tab(
          text: 'Trending',
        ),
        Tab(
          text: 'Offers',
        )
      ]);
}
