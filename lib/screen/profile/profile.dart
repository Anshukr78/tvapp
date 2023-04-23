import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/screen/profile/refer_and_earn.dart';
import 'package:harbour_ecommerce/screen/profile/returnWidget.dart';
import 'package:harbour_ecommerce/screen/profile/return_refund.dart';
import 'package:harbour_ecommerce/screen/profile/wishlist.dart';

import '../../component/loading.dart';
import '../../helper/button.dart';
import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/list_tile.dart';
import '../search_page/cart.dart';
import 'contact_us.dart';
import 'faqs.dart';
import 'orders.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: key,
        backgroundColor: AppColor.wFAFAFA,
        body : FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){

            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"),);
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Center(child: Text("Document does not exist"),);
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
              print(data);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarWidget(
                      cartCall: () {},
                      menuCall: () {
                        key.currentState!.openEndDrawer();
                      },
                    ),
                    SizedBox(
                      height: AppSize.heightMultiply(context, 0.81),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppSize.widthDivide(context, 16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedMedia.heightDivide(context, 80),
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Hey, ',
                                      style: AppText.montserrat50012pxb000000,
                                    ),
                                    TextSpan(
                                      text: data['first_name'] + " " + data['last_name'],
                                      style: AppText.montserrat50012pxb000000,
                                    ),
                                  ])),
                              SizedMedia.heightDivide(context, 50),
                              // profileListTile(context, () {}, 'Coupons: ', '6'),
                              // Divider(
                              //   thickness: 0.5,
                              //   color: AppColor.gE5E5E5,
                              // ),
                              profileListTile(context, () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                        const CartScreen())));
                              }, 'Cart: ', data['userCart'].length.toString()),
                              // button302(context, () {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: ((context) =>
                              //           const ReferAndEarnScreen())));
                              // }),
                              profileListTile(context, () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => const OrdersScreen())));
                              }, 'Orders ', ''),
                              Divider(
                                thickness: 0.5,
                                color: AppColor.gE5E5E5,
                              ),
                              profileListTile(context, () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => const ReturnRefundPage())));
                              }, 'Returns/Refunds', ''),
                              Divider(
                                thickness: 0.5,
                                color: AppColor.gE5E5E5,
                              ),
                              profileListTile(context, () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => const FAQs())));
                              }, 'FAQ', ''),
                              Divider(
                                thickness: 0.5,
                                color: AppColor.gE5E5E5,
                              ),
                              profileListTile(context, () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => const ContactUs())));
                              }, 'Contact Us', ''),
                              // Divider(
                              //   thickness: 0.5,
                              //   color: AppColor.gE5E5E5,
                              // ),
                              // profileListTile(
                              //     context, () {}, 'Shipping and delivery', ''),
                              Divider(
                                thickness: 0.5,
                                color: AppColor.gE5E5E5,
                              ),
                              profileListTile(context, () async{ await FirebaseAuth.instance.signOut(); }, 'Log out', ''),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }

            return const LoadingScreen();
          },
        ),
      ),
    );
  }
}
