import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/screen/home_page/place_an_order/order_details.dart';

import '../../component/loading.dart';
import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/order_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List orderList = [];

  getOrderDetails() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: otherAppBar(context, 'Previous orders'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.widthDivide(context, 16),
                vertical: AppSize.heightDivide(context, 80)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppText.gradientFFB319wo100nFF8A00wo100(
                //     'Previous orders', 18, FontWeight.w600),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('orders')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(snapshot.data!.docs[index]['userId'])
                                  .get(),
                              builder: (context, snapshotFuture) {
                                if (snapshotFuture.hasError) {
                                  return const Center(
                                    child: Text("Something went wrong"),
                                  );
                                }
                                if (snapshotFuture.connectionState ==
                                    ConnectionState.done) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OrderDetails(
                                            orderId: snapshot.data!.docs[index]
                                                ['id'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical:
                                            AppSize.heightDivide(context, 60),
                                      ),
                                      height:
                                          AppSize.heightDivide(context, 6.1538),
                                      width: AppSize.widthMultiply(context, 1),
                                      child: Row(
                                        children: [
                                          FutureBuilder(
                                              future: FirebaseFirestore.instance
                                                  .collection('product')
                                                  .doc(
                                                      snapshot.data!.docs[index]
                                                          ['productList'][0])
                                                  .get(),
                                              builder:
                                                  (context, snapshotFuture2) {
                                                //Map<String, dynamic>? mapValue = snapshotFuture.data!.data();

                                                if (snapshotFuture2.hasError) {
                                                  return const Center(
                                                    child: Text(
                                                        "Something went wrong"),
                                                  );
                                                }
                                                if (snapshotFuture2
                                                        .connectionState ==
                                                    ConnectionState.done) {
                                                  return Container(
                                                    width: AppSize.widthDivide(
                                                        context, 2.7692),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            snapshotFuture2
                                                                    .data!
                                                                    .data()![
                                                                'profile']),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return const LoadingScreen();
                                              }),
                                          SizedMedia.widthDivide(context, 20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: AppSize.widthDivide(
                                                    context, 2.5),
                                                child: Text(
                                                  snapshotFuture.data!.data()![
                                                          'first_name'] +
                                                      " " +
                                                      snapshotFuture.data!
                                                          .data()!['last_name'],
                                                  style: AppText
                                                      .montserrat50012pxb000000w85,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedMedia.heightDivide(
                                                  context, 80),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Deliver On ',
                                                    style: AppText
                                                        .montserrat50012pxb000000w85,
                                                  ),
                                                  Text(
                                                    '',
                                                    //snapshot.data!.docs[index]['orderDate'].toString(),
                                                    // DateTime.fromMillisecondsSinceEpoch(snapshot.data!.docs[index]['orderDate'] * 1000).toString(),
                                                    //DateTime(snapshot.data!.docs[index]['orderDate']).toString(),
                                                    style: AppText
                                                        .montserrat50012pxb000000w85,
                                                  ),
                                                ],
                                              ),
                                              SizedMedia.heightDivide(
                                                  context, 80),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Item no : ',
                                                    style: AppText
                                                        .montserrat50012pxb000000w85,
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]['productList'].length.toString(),
                                                    style: AppText
                                                        .montserrat50012pxb000000w85,
                                                  ),
                                                ],
                                              ),
                                              SizedMedia.heightDivide(
                                                  context, 80),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Paid Amount  :  ',
                                                    style: AppText
                                                        .montserrat50012pxb000000w85,
                                                  ),
                                                  Text(
                                                    '\$ ${snapshot.data!.docs[index]['totalAmount'].toString()}',
                                                    style: AppText
                                                        .montserrat50012pxb000000w85,
                                                  ),
                                                ],
                                              ),
                                              SizedMedia.heightDivide(
                                                  context, 80),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: AppSize.heightDivide(
                                                  context, 10),
                                              // left: AppSize.widthDivide(context, 7),
                                            ),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => OrderDetails(
                                                      orderId: snapshot.data!.docs[index]
                                                      ['id'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: AppColor.b000000,
                                                size: AppSize.heightDivide(
                                                    context, 40.666),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return const LoadingScreen();
                              });
                        });
                  },
                ),

                SizedMedia.heightDivide(context, 40),
                // const OrderWidget(),
                // const ReviewOrderWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
