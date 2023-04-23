import 'package:another_stepper/another_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harbour_ecommerce/screen/profile/faqs.dart';
import 'package:harbour_ecommerce/screen/profile/return_refund.dart';
import 'package:intl/intl.dart';

import '../../../component/loading.dart';
import '../../../helper/colors.dart';
import '../../../helper/size.dart';
import '../../../helper/text_style.dart';
import '../../../helper/widgets/main_button_widget.dart';
import '../../../helper/widgets/text_style_widget.dart';
import '../../../widget/app_bar.dart';
import '../../address/cancel_successful.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;

  const OrderDetails({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List deliveryStatusWithoutCancel = [
    'Ordered',
    'Packed',
    'Shipped',
    'Delivery'
  ];

  List deliveryStatusWithCancel = ['Ordered', 'Canceled'];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.wFAFAFA,
      appBar: otherAppBar(context, 'Order Details'),
      body: isLoading
          ? const LoadingScreen()
          : FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('orders')
                  .doc(widget.orderId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return const Center(
                    child: Text("Document does not exist"),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedMedia.heightDivide(context, 40),
                          Text(
                            'Order id:  ${widget.orderId}',
                            style: AppText.montserrat40012pxb000000w69,
                          ),
                          SizedMedia.heightDivide(context, 40),
                          Text(
                            'Deliver To : ',
                            style: AppText.montserrat70014pxb000000,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.black45,
                          ),
                          SizedMedia.heightDivide(context, 80),
                          FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection('address')
                                  .doc(snapshot.data!.data()!['address'])
                                  .get(),
                              builder: (context, snapshotFutureAddress) {
                                if (snapshotFutureAddress.hasError) {
                                  return const Center(
                                    child: Text("Something went wrong"),
                                  );
                                }

                                if (snapshotFutureAddress.hasData &&
                                    !snapshotFutureAddress.data!.exists) {
                                  return const Center(
                                    child: Text("Document does not exist"),
                                  );
                                }

                                if (snapshotFutureAddress.connectionState ==
                                    ConnectionState.done) {
                                  Map<String, dynamic> dataAddress =
                                      snapshotFutureAddress.data!.data()
                                          as Map<String, dynamic>;
                                  print(dataAddress);

                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${dataAddress['first_name']} ${dataAddress['last_name']}',
                                        style: AppText.montserrat40014pxb000000,
                                      ),
                                      SizedMedia.heightDivide(context, 200),
                                      Text(
                                        '${dataAddress['address']}, ${dataAddress['landmark']}, ${dataAddress['city']},\n${dataAddress['country']}, ${dataAddress['pincode']}',
                                        style: AppText.montserrat40014pxb000000,
                                      ),
                                      SizedMedia.heightDivide(context, 200),
                                      Text(
                                        '${dataAddress['phone_number']}',
                                        style: AppText.montserrat40014pxb000000,
                                      ),
                                    ],
                                  );
                                }

                                return const LoadingScreen();
                              }),
                          SizedMedia.heightDivide(context, 80),
                          Text(
                            'Product : ',
                            style: AppText.montserrat70014pxb000000,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.black45,
                          ),
                          ListView.separated(
                            itemCount:
                                snapshot.data!.data()!['productList'].length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('product')
                                      .doc(snapshot.data!.data()!['productList']
                                          [index])
                                      .get(),
                                  builder: (context, snapshotFutureProduct) {
                                    if (snapshotFutureProduct.hasError) {
                                      return const Center(
                                        child: Text("Something went wrong"),
                                      );
                                    }

                                    if (snapshotFutureProduct.hasData &&
                                        !snapshotFutureProduct.data!.exists) {
                                      return const Center(
                                        child: Text("Document does not exist"),
                                      );
                                    }

                                    if (snapshotFutureProduct.connectionState ==
                                        ConnectionState.done) {
                                      Map<String, dynamic> dataProduct =
                                          snapshotFutureProduct.data!.data()
                                              as Map<String, dynamic>;

                                      return GestureDetector(
                                        onTap: () {
                                          if (snapshot.data!
                                                      .data()!['orderStatus'] ==
                                                  'Delivery' &&
                                              DateTime.now()
                                                      .difference(snapshot.data!
                                                          .data()![
                                                              'deliveryDate']
                                                          .toDate())
                                                      .inDays <=
                                                  7) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReturnRefund(
                                                          orderId:
                                                              widget.orderId,
                                                          productIndex: index,
                                                        )));
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: AppSize.heightDivide(
                                                context, 70),
                                          ),
                                          height: AppSize.heightDivide(
                                              context, 5.2),
                                          width:
                                              AppSize.widthMultiply(context, 1),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        AppSize.heightDivide(
                                                            context, 20),
                                                    width: AppSize.widthDivide(
                                                        context, 1.9047),
                                                    child: Text(
                                                      dataProduct['name'],
                                                      style: AppText
                                                          .montserrat60013pxb000000,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Size : ',
                                                        style: AppText
                                                            .montserrat50012pxg9E9E9E,
                                                      ),
                                                      Text(
                                                        snapshot.data!.data()![
                                                                'productSize']
                                                            [index],
                                                        style: AppText
                                                            .montserrat50012pxg9E9E9E,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Brand: ',
                                                        style: AppText
                                                            .montserrat50012pxg9E9E9E,
                                                      ),
                                                      dataProduct['brand'] ==
                                                              'G'
                                                          ? Text(
                                                              'G',
                                                              style: GoogleFonts
                                                                  .cuprum(
                                                                color: const Color(
                                                                    0xff473001),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                letterSpacing:
                                                                    0.2,
                                                              ),
                                                            )
                                                          : Text(
                                                              'L.H',
                                                              style: GoogleFonts
                                                                  .damion(
                                                                color: const Color(
                                                                    0xff473001),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                letterSpacing:
                                                                    0.2,
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                  SizedMedia.heightDivide(
                                                      context, 120),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '\$ ${dataProduct['price'].toString()}',
                                                        style: AppText
                                                            .montserrat60020pxb000000,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedMedia.heightDivide(
                                                      context, 100),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Icon(
                                                          Icons.star,
                                                          color:
                                                              AppColor.gD9D9D9,
                                                          size: AppSize
                                                              .heightDivide(
                                                                  context,
                                                                  44.444),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Icon(
                                                          Icons.star,
                                                          color:
                                                              AppColor.gD9D9D9,
                                                          size: AppSize
                                                              .heightDivide(
                                                                  context,
                                                                  44.444),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Icon(
                                                          Icons.star,
                                                          color:
                                                              AppColor.gD9D9D9,
                                                          size: AppSize
                                                              .heightDivide(
                                                                  context,
                                                                  44.444),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Icon(
                                                          Icons.star,
                                                          color:
                                                              AppColor.gD9D9D9,
                                                          size: AppSize
                                                              .heightDivide(
                                                                  context,
                                                                  44.444),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Icon(
                                                          Icons.star,
                                                          color:
                                                              AppColor.gD9D9D9,
                                                          size: AppSize
                                                              .heightDivide(
                                                                  context,
                                                                  44.444),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedMedia.heightDivide(
                                                      context, 80),
                                                  Text(
                                                    'Rate This Product Now',
                                                    style: AppText
                                                        .montserrat50012pxb000000w85,
                                                  )
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height:
                                                        AppSize.heightDivide(
                                                            context, 6.3816),
                                                    width: AppSize.widthDivide(
                                                        context, 3.7894),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            dataProduct[
                                                                'profile']),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Quantity : ${snapshot.data!.data()!['productQuantity'][index].toString()}',
                                                    style: AppText
                                                        .montserrat40012pxb000000,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }

                                    return const LoadingScreen();
                                  });
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                thickness: 1,
                                color: Colors.black.withOpacity(0.10),
                              );
                            },
                          ),
                          AnotherStepper(
                            stepperList: snapshot.data!
                                        .data()!['orderStatus'] ==
                                    'Canceled'
                                ? [
                                    StepperData(
                                        title: StepperText(
                                          'Ordered',
                                          textStyle: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.5),
                                        ),
                                        subtitle: StepperText(
                                          DateFormat('EEEE, MM d, yyyy')
                                              .format(snapshot.data!
                                                  .data()!['orderDate']
                                                  .toDate())
                                              .toString(),
                                          textStyle: GoogleFonts.montserrat(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              color: const Color(0xff9E9E9E)),
                                        )),
                                    StepperData(
                                        title: StepperText(
                                          'Canceled',
                                          textStyle: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.5),
                                        ),
                                        subtitle: StepperText(
                                          DateFormat('EEEE, MM d, yyyy')
                                              .format(snapshot.data!
                                                  .data()!['deliveryDate']
                                                  .toDate())
                                              .toString(),
                                          textStyle: GoogleFonts.montserrat(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              color: const Color(0xff9E9E9E)),
                                        )),
                                  ]
                                : [
                                    StepperData(
                                        title: StepperText(
                                          'Ordered',
                                          textStyle: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.5),
                                        ),
                                        subtitle: StepperText(
                                          DateFormat('EEEE, MM d, yyyy')
                                              .format(snapshot.data!
                                                  .data()!['orderDate']
                                                  .toDate())
                                              .toString(),
                                          textStyle: GoogleFonts.montserrat(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              color: const Color(0xff9E9E9E)),
                                        )),
                                    StepperData(
                                        title: StepperText(
                                          'Packed',
                                          textStyle: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.5),
                                        ),
                                        subtitle: StepperText(
                                          snapshot.data!
                                                      .data()!['orderStatus'] !=
                                                  'Delivered'
                                              ? 'Expected by ${DateFormat('EEEE, MM d, yyyy').format(snapshot.data!.data()!['orderDate'].toDate().add(const Duration(days: 5))).toString()}'
                                              : 'Expected by ${DateFormat('EEEE, MM d, yyyy').format(snapshot.data!.data()!['orderDate'].toDate().add(const Duration(days: 1))).toString()}',
                                          textStyle: GoogleFonts.montserrat(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              color: const Color(0xff9E9E9E)),
                                        )),
                                    StepperData(
                                        title: StepperText(
                                          'Shipped',
                                          textStyle: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.5),
                                        ),
                                        subtitle: StepperText(
                                          snapshot.data!
                                                      .data()!['orderStatus'] !=
                                                  'Delivered'
                                              ? 'Expected by ${DateFormat('EEEE, MM d, yyyy').format(snapshot.data!.data()!['orderDate'].toDate().add(const Duration(days: 5))).toString()}'
                                              : 'Expected by ${DateFormat('EEEE, MM d, yyyy').format(snapshot.data!.data()!['orderDate'].toDate().add(const Duration(days: 3))).toString()}',
                                          textStyle: GoogleFonts.montserrat(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              color: const Color(0xff9E9E9E)),
                                        )),
                                    StepperData(
                                        title: StepperText(
                                          'Delivery',
                                          textStyle: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.5),
                                        ),
                                        subtitle: StepperText(
                                          snapshot.data!
                                                      .data()!['orderStatus'] !=
                                                  'Delivered'
                                              ? 'Expected by ${DateFormat('EEEE, MM d, yyyy').format(snapshot.data!.data()!['orderDate'].toDate().add(const Duration(days: 5))).toString()} \nShipment yet to be delivered'
                                              : 'Delivered by ${DateFormat('EEEE, MM d, yyyy').format(snapshot.data!.data()!['deliveryDate'].toDate()).toString()}',
                                          textStyle: GoogleFonts.montserrat(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              color: const Color(0xff9E9E9E)),
                                        )),
                                  ],
                            stepperDirection: Axis.vertical,
                            activeBarColor: AppColor.oFFB319,
                            activeIndex: snapshot.data!
                                        .data()!['orderStatus'] ==
                                    'Canceled'
                                ? 1
                                : snapshot.data!.data()!['orderStatus'] ==
                                        'Packed'
                                    ? 1
                                    : snapshot.data!.data()!['orderStatus'] ==
                                            'Shipped'
                                        ? 2
                                        : snapshot.data!
                                                    .data()!['orderStatus'] ==
                                                'Delivered'
                                            ? 3
                                            : 0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: AppSize.heightDivide(context, 80)),
                            height: AppSize.heightDivide(context, 7.2072),
                            width: AppSize.widthMultiply(context, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price Details',
                                  style: AppText.montserrat60013pxb000000,
                                ),

                                SizedMedia.heightDivide(context, 100),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Price(${snapshot.data!.data()!['productList'].length.toString()} item)',
                                      style: AppText.montserrat40012pxb000000,
                                    ),
                                    Text(
                                      '₹ ${snapshot.data!.data()!['totalAmount'].toString()}',
                                      style: AppText.montserrat40012pxb000000,
                                    ),
                                  ],
                                ),

                                // SizedMedia.heightDivide(context, 220),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       'Discount',
                                //       style: AppText.montserrat40012pxb000000,
                                //     ),
                                //     Text(
                                //       '-5',
                                //       style: AppText.montserrat40012pxb000000,
                                //     ),
                                //   ],
                                // ),

                                SizedMedia.heightDivide(context, 220),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Delivery Charges',
                                      style: AppText.montserrat40012pxb000000,
                                    ),
                                    Text(
                                      'FREE',
                                      style: AppText.montserrat40012pxb000000,
                                    ),
                                  ],
                                ),

                                Divider(
                                  color: AppColor.gF1F1F1w78,
                                  thickness: 2,
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Amount',
                                      style: AppText.montserrat50012pxb000000,
                                    ),
                                    Text(
                                      '₹ ${snapshot.data!.data()!['paidAmount'].toString()}',
                                      style: AppText.montserrat50012pxb000000,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedMedia.heightDivide(context, 80),
                          snapshot.data!.data()!['orderStatus'] == 'Canceled'
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: primaryButton(
                                          context: context,
                                          text: 'Cancel',
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          'Do you want to cancel your order?',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: AppText
                                                              .montserrat60020pxb403C3C,
                                                        ),
                                                        content: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20),
                                                          height: 80,
                                                          child: Column(
                                                            children: [
                                                              primaryButton(
                                                                  context:
                                                                      context,
                                                                  text:
                                                                      'Cancel',
                                                                  onTap:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      isLoading =
                                                                          true;
                                                                    });

                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .runTransaction(
                                                                            (transaction) async {
                                                                      DocumentReference documentReference = FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'orders')
                                                                          .doc(widget
                                                                              .orderId);

                                                                      DocumentSnapshot
                                                                          snapShotDataUpdate =
                                                                          await transaction
                                                                              .get(documentReference);

                                                                      transaction
                                                                          .update(
                                                                              documentReference,
                                                                              {
                                                                            'orderStatus':
                                                                                'Canceled',
                                                                            'deliveryDate':
                                                                                DateTime.now()
                                                                          });
                                                                    });
                                                                    setState(
                                                                        () {
                                                                      isLoading =
                                                                          false;
                                                                    });
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                CancelSuccessful(comment: 'Order Cancelled \nsuccessfully',)));
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                });
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            // elevation: MaterialStateProperty.all(25),
                                            shadowColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FAQs()));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20),
                                                child: Center(
                                                  child: CustomText(
                                                    text: 'Need Help ?',
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                          SizedMedia.heightDivide(context, 80),
                        ],
                      ),
                    ),
                  );
                }

                return const LoadingScreen();
              },
            ),
    );
  }
}
