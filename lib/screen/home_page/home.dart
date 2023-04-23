import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harbour_ecommerce/model/product.dart';

import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/grid_view_box.dart';
import '../product_details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('product').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
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

            return SingleChildScrollView(
              child: Column(
                children: [
                  SearchAppBar(
                      cartCall: () {}, menuCall: () {}, searchField: false),
                  SizedMedia.heightDivide(context, 80),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.widthDivide(context, 16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.gradientFFB319wo100nFF8A00wo100(
                            'Filter', 14, FontWeight.w500),
                        InkWell(
                            onTap: () {},
                            child: SvgPicture.asset('images/filter.svg')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppSize.widthDivide(context, 16),
                      top: AppSize.heightDivide(context, 80),
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Text(
                              'brand',
                              style: AppText.montserrat50010pxb000000w29,
                            )),
                        SizedMedia.widthDivide(context, 20),
                        InkWell(
                            onTap: () {},
                            child: Text(
                              'price',
                              style: AppText.montserrat50010pxb000000w29,
                            )),
                        SizedMedia.widthDivide(context, 20),
                        InkWell(
                            onTap: () {},
                            child: Text(
                              'categories',
                              style: AppText.montserrat50010pxb000000w29,
                            )),
                        SizedMedia.widthDivide(context, 20),
                        InkWell(
                            onTap: () {},
                            child: Text(
                              'sale',
                              style: AppText.montserrat50010pxb000000w29,
                            )),
                      ],
                    ),
                  ),
                  SizedMedia.heightDivide(context, 60),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.widthDivide(context, 16),
                      // vertical: AppSize.heightDivide(context, 40)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.gradientFFB319wo100nFF8A00wo100(
                            'Trending', 14, FontWeight.w500),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'See All',
                              style: AppText.montserrat50010pxb000000,
                            )),
                      ],
                    ),
                  ),
                  GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.widthDivide(context, 16),
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 40,
                        crossAxisSpacing: 40,
                        childAspectRatio: 139 / 230),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProductDetailsScreen(
                              productClass: ProductClass(
                                  imageUrl: snapshot.data!.docs[index]
                                      ['profile'],
                                  productPrice: snapshot.data!.docs[index]
                                      ['price'],
                                  size: snapshot.data!.docs[index]['size'],
                                  brand: snapshot.data!.docs[index]['brand'],
                                  category: snapshot.data!.docs[index]
                                      ['category'],
                                  id: snapshot.data!.docs[index]['id'],
                                  productDescrition: snapshot.data!.docs[index]
                                      ['description'],
                                  productName: snapshot.data!.docs[index]
                                      ['name'],
                                qty: 1,
                              ),
                            );
                          }));
                        },
                        child: HomeGridViewBox(
                          productClass: ProductClass(
                              imageUrl: snapshot.data!.docs[index]['profile'],
                              productPrice: snapshot.data!.docs[index]['price'],
                              size: snapshot.data!.docs[index]['size'],
                              brand: snapshot.data!.docs[index]['brand'],
                              category: snapshot.data!.docs[index]['category'],
                              id: snapshot.data!.docs[index]['id'],
                              productDescrition: snapshot.data!.docs[index]
                                  ['description'],
                              productName: snapshot.data!.docs[index]['name'],
                              qty: 1),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
