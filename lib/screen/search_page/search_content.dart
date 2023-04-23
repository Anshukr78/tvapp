import 'package:flutter/material.dart';

import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/drawer.dart';
import '../../widget/grid_view_box.dart';
import '../../widget/rectangle_widget.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({super.key});

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: key,
          backgroundColor: AppColor.wFAFAFA,
          endDrawer: searchDrawer(context),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchAppBar(
                    searchField: true,
                    cartCall: () {},
                    menuCall: () {
                      key.currentState!.openEndDrawer();
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSize.heightDivide(context, 40),
                      horizontal: AppSize.widthDivide(context, 16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.gradientFFB319wo100nFF8A00wo100(
                          'Previous Search', 14, FontWeight.w500),
                      SizedMedia.heightDivide(context, 70),
                      searchRectangle(context),
                      SizedMedia.heightDivide(context, 20),
                      AppText.gradientFFB319wo100nFF8A00wo100(
                          'Top Search', 14, FontWeight.w500),
                      SizedMedia.heightDivide(context, 70),
                      searchRectangle(context),
                      SizedMedia.heightDivide(context, 20),
                      AppText.gradientFFB319wo100nFF8A00wo100(
                          'Categories', 14, FontWeight.w500),
                      SizedMedia.heightDivide(context, 70),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 139 / 101),
                          itemBuilder: ((context, index) {
                            return searchContentGridViewBox(context);
                          }))
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
