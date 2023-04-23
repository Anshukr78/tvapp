import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../component/loading.dart';
import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';



class RefundOverview extends StatefulWidget {
  final String refundId;
  const RefundOverview({Key? key, required this.refundId}) : super(key: key);

  @override
  State<RefundOverview> createState() => _RefundOverviewState();
}

class _RefundOverviewState extends State<RefundOverview> {

  bool loading = false;

  DocumentSnapshot? snapshotRefund, snapshotAddress;

  void getData() async {
    setState(() {
      loading = true;
    });

    snapshotRefund = await FirebaseFirestore.instance
        .collection('refunds')
        .doc(widget.refundId)
        .get();

    getAddress();
  }

  void getAddress()async{

    snapshotAddress = await FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('address').doc(snapshotRefund!['addressId'])
        .get();

    setState(() {});

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: otherAppBar(context, ''),
        body: loading ? const LoadingScreen() : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.heightDivide(context, 60),
              horizontal: AppSize.widthDivide(context, 25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.gradientFFB319wo100nFF8A00wo100(
                    'Refund/Return Details', 18, FontWeight.w600),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('product')
                        .doc(snapshotRefund!['productId'])
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

                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: AppSize.heightDivide(context, 70),
                          ),
                          height: AppSize.heightDivide(context, 5.2),
                          width: AppSize.widthMultiply(context, 1),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height:
                                    AppSize.heightDivide(context, 20),
                                    width: AppSize.widthDivide(
                                        context, 1.9047),
                                    child: Text(
                                      dataProduct['name'],
                                      style: AppText
                                          .montserrat60013pxb000000,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
                                        snapshotRefund!['productSize'],
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
                                      dataProduct['brand'] == 'G'
                                          ? Text(
                                        'G',
                                        style: GoogleFonts.cuprum(
                                          color: const Color(
                                              0xff473001),
                                          fontWeight:
                                          FontWeight.w600,
                                          letterSpacing: 0.2,
                                        ),
                                      )
                                          : Text(
                                        'L.H',
                                        style: GoogleFonts.damion(
                                          color: const Color(
                                              0xff473001),
                                          fontWeight:
                                          FontWeight.w600,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedMedia.heightDivide(context, 120),
                                  Row(
                                    children: [
                                      Text(
                                        'Refundable Amount : - \n₹ ${snapshotRefund!['refundAmount'].toString()}',
                                        style: AppText
                                            .montserrat60013pxb000000,
                                      ),
                                      SizedMedia.widthDivide(context, 30),
                                      // AppText.gradientFFB319wo100nFF8A00wo100(
                                      //     '1 Offer', 12, FontWeight.w700)
                                    ],
                                  ),
                                  SizedMedia.heightDivide(context, 100),
                                  Text(
                                    'Refund requested on \n${DateFormat('EEEE, MM d, yyyy').format(snapshotRefund!['refundRequestDate'].toDate()).toString()}',
                                    style:
                                    AppText.montserrat40012pxb000000,
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: AppSize.heightDivide(
                                        context, 6.3816),
                                    width: AppSize.widthDivide(
                                        context, 3.7894),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(9),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                dataProduct['profile']),
                                            fit: BoxFit.cover)),
                                  ),
                                  Text(
                                    'Quantity : ${snapshotRefund!['productQuantity'].toString()}',
                                    style:
                                    AppText.montserrat40012pxb000000,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }

                      return const LoadingScreen();
                    }),
                SizedMedia.heightDivide(context, 120),
                Text(
                  'Refund Type',
                  style: AppText.montserrat60016pxb000000,
                ),
                ListTile(
                  minLeadingWidth: AppSize.widthDivide(context, 20),
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    height: AppSize.heightDivide(context, 44.444),
                    width: AppSize.widthDivide(context, 20),
                    decoration: BoxDecoration(
                        gradient:
                        LinearGradient(colors: [AppColor.oFFB319, AppColor.oFF8A00])),

                    child: Checkbox(
                        side: BorderSide(color: AppColor.g9E9E9E, width: 2),
                        activeColor: Colors.transparent,
                        checkColor: AppColor.wFFFFFF,
                        value: true, onChanged: (bool? value) {  },
                    ),
                  ),
                  title: Text(
                    snapshotRefund!['refundPaymentMethod'],
                    style: AppText.montserrat50018pxb000000,
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: AppSize.heightDivide(context, 120)),
                  height: AppSize.heightDivide(context, 13.3333),
                  width: AppSize.widthMultiply(context, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshotAddress!['first_name'] + ' ' + snapshotAddress!['last_name'],
                        style: AppText.montserrat60010pxg9E9E9E,
                      ),
                      Text(
                        '${snapshotAddress!['address']}, ${snapshotAddress!['landmark']}, ${snapshotAddress!['city']}, \n${snapshotAddress!['country']}, ${snapshotAddress!['pincode']},  ',
                        style: AppText.montserrat60010pxg9E9E9E,
                      ),
                      Text(
                        'phone number - ${snapshotAddress!['phone_number']}',
                        style: AppText.montserrat60010pxg9E9E9E,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Track Your Refund Order',
                  style: AppText.montserrat60016pxb000000,
                ),
                AnotherStepper(
                  stepperList: snapshotRefund!['refundStatus'] ==
                      'Return Canceled'
                      ? [
                    StepperData(
                      title: StepperText(
                        'Return Requested',
                        textStyle: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5),
                      ),
                      // subtitle: StepperText(
                      //   DateFormat('EEEE, MM d, yyyy')
                      //       .format(snapshotRefund!['refundRequestDate']
                      //       .toDate())
                      //       .toString(),
                      //   textStyle: GoogleFonts.montserrat(
                      //       fontSize: 11,
                      //       fontWeight: FontWeight.w500,
                      //       letterSpacing: 1.5,
                      //       color: const Color(0xff9E9E9E)),
                      // ),
                    ),
                    StepperData(
                      title: StepperText(
                        'Return Canceled',
                        textStyle: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5),
                      ),
                      // subtitle: StepperText(
                      //   DateFormat('EEEE, MM d, yyyy')
                      //       .format(snapshotRefund!['refundCompleteDate']
                      //       .toDate())
                      //       .toString(),
                      //   textStyle: GoogleFonts.montserrat(
                      //       fontSize: 11,
                      //       fontWeight: FontWeight.w500,
                      //       letterSpacing: 1.5,
                      //       color: const Color(0xff9E9E9E)),
                      // ),
                    ),
                  ]
                      : [
                    StepperData(
                      title: StepperText(
                        'Return Requested',
                        textStyle: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5),
                      ),
                      // subtitle: StepperText(
                      //   DateFormat('EEEE, MM d, yyyy')
                      //       .format(snapshotRefund!['refundRequestDate']
                      //       .toDate())
                      //       .toString(),
                      //   textStyle: GoogleFonts.montserrat(
                      //       fontSize: 11,
                      //       fontWeight: FontWeight.w500,
                      //       letterSpacing: 1.5,
                      //       color: const Color(0xff9E9E9E)),
                      // ),
                    ),
                    StepperData(
                      title: StepperText(
                        'Return Approved',
                        textStyle: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5),
                      ),
                      // subtitle: StepperText(
                      //   snapshotRefund!['refundStatus'] !=
                      //       'Delivered'
                      //       ? 'Expected by ${DateFormat('EEEE, MM d, yyyy').format(snapshot.data!.data()!['orderDate'].toDate().add(const Duration(days: 5))).toString()}'
                      //       : 'Expected by ${DateFormat('EEEE, MM d, yyyy').format(snapshot.data!.data()!['orderDate'].toDate().add(const Duration(days: 1))).toString()}',
                      //   textStyle: GoogleFonts.montserrat(
                      //       fontSize: 11,
                      //       fontWeight: FontWeight.w500,
                      //       letterSpacing: 1.5,
                      //       color: const Color(0xff9E9E9E)),
                      // ),
                    ),
                    StepperData(
                      title: StepperText(
                        'Product Picked Up',
                        textStyle: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5),
                      ),
                      // subtitle: StepperText(
                      //   snapshotRefund!['refundStatus'] !=
                      //       'Delivered'
                      //       ? 'Expected by ${DateFormat('EEEE, MM d, yyyy').format(snapshot.data!.data()!['orderDate'].toDate().add(const Duration(days: 5))).toString()}'
                      //       : 'Expected by ${DateFormat('EEEE, MM d, yyyy').format(snapshot.data!.data()!['orderDate'].toDate().add(const Duration(days: 3))).toString()}',
                      //   textStyle: GoogleFonts.montserrat(
                      //       fontSize: 11,
                      //       fontWeight: FontWeight.w500,
                      //       letterSpacing: 1.5,
                      //       color: const Color(0xff9E9E9E)),
                      // ),
                    ),
                    StepperData(
                      title: StepperText(
                        'Refund Processed',
                        textStyle: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5),
                      ),
                      // subtitle: StepperText(
                      //   snapshotRefund!['refundStatus'] !=
                      //       'Refund Processed'
                      //       ? 'Expected by ${DateFormat('EEEE, MM d, yyyy').format(snapshotRefund!['refundRequestDate'].toDate().add(const Duration(days: 3))).toString()} \nShipment yet to be delivered'
                      //       : 'Delivered by ${DateFormat('EEEE, MM d, yyyy').format(snapshotRefund()!['deliveryDate'].toDate()).toString()}',
                      //   textStyle: GoogleFonts.montserrat(
                      //       fontSize: 11,
                      //       fontWeight: FontWeight.w500,
                      //       letterSpacing: 1.5,
                      //       color: const Color(0xff9E9E9E)),
                      // ),
                    ),
                  ],
                  stepperDirection: Axis.vertical,
                  activeBarColor: AppColor.oFFB319,
                  activeIndex: snapshotRefund!['refundStatus'] ==
                      'Return Canceled'
                      ? 1
                      : snapshotRefund!['refundStatus'] ==
                      'Return Approved'
                      ? 1
                      : snapshotRefund!['refundStatus'] ==
                      'Product Picked Up'
                      ? 2
                      : snapshotRefund!['refundStatus'] ==
                      'Refund Processed'
                      ? 3
                      : 0,
                ),
                SizedMedia.heightDivide(context, 40),
                Text(
                  'Note:',
                  style: AppText.montserrat60013pxb000000,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: AppSize.heightDivide(context, 120)),
                  height: AppSize.heightDivide(context, 13.3333),
                  width: AppSize.widthMultiply(context, 1),
                  child: Text(
                    '*we can only accept items for return or replacement, if they have not been used or damaged',
                    style: AppText.montserrat60010pxg9E9E9E,
                  ),
                ),
                SizedMedia.heightDivide(context, 40),
              ],
            ),
          ),
        ),
        // bottomSheet: bottomSheetButton(context, () {
        //   uploadRefundValue();
        // }, 'Send Request'),
      ),
    );
  }
}
