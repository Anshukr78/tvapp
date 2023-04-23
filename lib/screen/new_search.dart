import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../helper/size.dart';
import '../helper/text_style.dart';
import '../widget/app_bar.dart';
import '../widget/image_slide_show.dart';
import '../widget/list_view_box.dart';
import '../widget/tab_bar.dart';
import '../widget/tab_bar_view.dart';

class SearchNewScreen extends StatefulWidget {
  const SearchNewScreen({Key? key}) : super(key: key);

  @override
  State<SearchNewScreen> createState() => _SearchNewScreenState();
}

class _SearchNewScreenState extends State<SearchNewScreen> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SlidingUpPanel(
          minHeight: AppSize.heightMultiply(context, 0.39),
          maxHeight: AppSize.heightMultiply(context, 1),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
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
          panelBuilder: (controller) {
            return DefaultTabController(
              length: 2,
              child: ListView(
                padding: EdgeInsets.all(20),
                controller: controller,
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
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: AppSize.heightDivide(context, 80),
                    ),
                    height: AppSize.heightDivide(context, 8),
                    width: AppSize.widthMultiply(context, 1),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Category')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                                child: Text('Something went wrong'));
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                                child: Text(
                              'This category \n\n has no items yet !',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Acme',
                                  letterSpacing: 1.5),
                            ));
                          }

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return categoriesListViewBox(
                                    context: context,
                                    categoryName: snapshot.data!.docs[index]
                                        ['name'],
                                    imageUrl: snapshot.data!.docs[index]
                                        ['image']);
                              },
                            ),
                          );
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
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSize.heightDivide(context, 80),
                    ),
                    height: AppSize.heightMultiply(context, 1.5),
                    width: AppSize.widthMultiply(context, 1),
                    child: TabBarView(
                      children: [
                        const TrendingTabBarView(),
                        offersTabBarView(context),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
