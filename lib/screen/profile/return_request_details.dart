import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harbour_ecommerce/component/loading.dart';
import 'package:harbour_ecommerce/screen/refund/refund_overview.dart';
import 'package:intl/intl.dart';

import '../../helper/button.dart';
import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/rectangle_widget.dart';


class ReturnRequestDetails extends StatefulWidget {
  final String refundId;
  const ReturnRequestDetails({super.key, required this.refundId});

  @override
  State<ReturnRequestDetails> createState() => _ReturnRequestDetailsState();
}

class _ReturnRequestDetailsState extends State<ReturnRequestDetails> {

  bool loading = false;
  DocumentSnapshot? snapshotRefund;

  void cancel()async{
    setState(
            () {
              loading =
          true;
        });

    await FirebaseFirestore
        .instance
        .runTransaction(
            (transaction) async {
          DocumentReference documentReference = FirebaseFirestore
              .instance
              .collection(
              'refunds')
              .doc(widget
              .refundId);

          DocumentSnapshot
          snapShotDataUpdate =
          await transaction
              .get(documentReference);

          transaction
              .update(
              documentReference,
              {
                'refundStatus':
                'Return Canceled',
                'refundCompleteDate':
                DateTime.now()
              });
        });
    setState(
            () {
              loading =
          false;
        });
  }

  void getData() async {
    setState(() {
      loading = true;
    });

    snapshotRefund = await FirebaseFirestore.instance
        .collection('refunds')
        .doc(widget.refundId)
        .get();

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  List text = [
    'Return Request',
    'Return Approved',
    'Product Picked Up',
    'Refund Processed'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: otherAppBar(context, 'Return Request Details'),
        body: loading ? const LoadingScreen() : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.heightDivide(context, 60),
              horizontal: AppSize.widthDivide(context, 25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Return Request Details',
                  style: AppText.montserrat60016pxb000000,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: AppSize.heightDivide(context, 50)),
                  padding: EdgeInsets.symmetric(
                    vertical: AppSize.heightDivide(context, 27),
                    horizontal: AppSize.widthDivide(context, 13),
                  ),
                  height: AppSize.heightDivide(context, 5.4421),
                  width: AppSize.widthMultiply(context, 1),
                  decoration: BoxDecoration(
                      color: AppColor.oFFB319,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                          color: AppColor.oFF8A00,
                          width: 1,
                          strokeAlign:  BorderSide.strokeAlignInside)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Return ID - ',
                            style: AppText.montserrat60012pxb403C3C,
                          ),
                          SizedBox(
                            width: 225,
                            child: Text(
                              snapshotRefund!['id'],
                              style: AppText.montserrat60012pxb403C3C,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Reason - ',
                            style: AppText.montserrat60012pxb403C3C,
                          ),
                          Text(
                            snapshotRefund!['reason'],
                            style: AppText.montserrat60012pxb403C3C,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Return Quantity - ',
                            style: AppText.montserrat60012pxb403C3C,
                          ),
                          Text(
                            snapshotRefund!['productQuantity'].toString(),
                            style: AppText.montserrat60012pxb403C3C,
                          ),
                        ],
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

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> RefundOverview(refundId: snapshotRefund!['id'])));
                  },
                  child: AppText.gradientFFB319wo100nFF8A00wo100(
                      'View All Tracking Details', 12, FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: bottomSheetButton(context, () { cancel();}, 'Cancel Return'),
      ),
    );
  }
}
