import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/drawer.dart';
import '../../widget/image_slide_show.dart';
import '../../widget/list_view_box.dart';
import '../../widget/tab_bar.dart';
import '../../widget/tab_bar_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  PanelController _pc = PanelController();

  // var searchField = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: key,
          backgroundColor: AppColor.wFAFAFA,
          endDrawer: searchDrawer(context),
          body: SlidingUpPanel(
            controller: _pc,
            // maxHeight: AppSize.heightDivide(context, 1.6),
            minHeight: AppSize.heightDivide(context, 2.1),
            isDraggable: false,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(31),
              topRight: Radius.circular(31),
            ),
            body: SizedBox(
              height: AppSize.heightDivide(context, 1.6949),
              width: AppSize.widthMultiply(context, 1),
              child: Stack(
                children: [
                  imageSlider(context),
                  SearchAppBar(
                    cartCall: () {},
                    menuCall: () {
                      key.currentState!.openEndDrawer();
                    },
                    searchField: false,
                  ),
                ],
              ),
            ),
            panel: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.widthDivide(context, 16),
              ),
              width: AppSize.widthMultiply(context, 1),
              decoration: BoxDecoration(
                  color: AppColor.wFAFAFA,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(31),
                    topRight: Radius.circular(31),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedMedia.heightDivide(context, 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: AppText.montserrat50014pxb000000,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'See All',
                            style: AppText.montserrat50010pxb000000,
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: AppSize.heightDivide(context, 80),
                      ),
                      height: AppSize.heightDivide(context, 11.0627),
                      width: AppSize.widthMultiply(context, 1),
                      child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return categoriesListViewBox(
                                context: context,
                                categoryName: '',
                                imageUrl: '');
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: AppSize.widthMultiply(context, 0.4),
                          child: searchPageTabBar(context),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'See All',
                            style: AppText.montserrat50010pxb000000,
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSize.heightDivide(context, 80),
                      ),
                      height: AppSize.heightMultiply(context, 0.2342),
                      width: AppSize.widthMultiply(context, 1),
                      child: TabBarView(children: [
                        const TrendingTabBarView(),
                        offersTabBarView(context),
                      ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
