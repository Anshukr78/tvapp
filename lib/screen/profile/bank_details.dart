import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../component/loading.dart';
import '../../helper/button.dart';
import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/check_box.dart';
import '../../widget/rectangle_widget.dart';
import 'bank_details2.dart';

class BankDetails extends StatefulWidget {
  final String orderId;
  final int productIndex;
  final String reasonReturn;
  final String details;
  final imageFile;

  const BankDetails(
      {super.key,
      required this.orderId,
      required this.productIndex,
      required this.reasonReturn,
      required this.details,
      required this.imageFile});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  bool upi = false;
  bool wallet = false;
  bool bank = false;
  bool card = false;

  bool loading = false;
  var selectedItem;
  DocumentSnapshot? snapshotProduct;
  var productId, productSize, productQuantity, deliveryDate;


  void getData() async {
    setState(() {
      loading = true;
    });

    snapshotProduct = await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .get();
    setState(() {});
    setState(() {
      productId = snapshotProduct!['productList'];
      productSize = snapshotProduct!['productSize'];
      productQuantity = snapshotProduct!['productQuantity'];
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
      child: loading ? LoadingScreen() : Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: otherAppBar(context, ''),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.heightDivide(context, 60),
              horizontal: AppSize.widthDivide(context, 25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.gradientFFB319wo100nFF8A00wo100(
                    'Product Details', 18, FontWeight.w600),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('product')
                        .doc(productId[widget.productIndex])
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
                            MainAxisAlignment.spaceBetween,
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
                                        productSize[widget.productIndex],
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
                                        '₹ ${dataProduct['price'].toString()}',
                                        style: AppText
                                            .montserrat60020pxb000000,
                                      ),
                                      SizedMedia.widthDivide(context, 30),
// AppText.gradientFFB319wo100nFF8A00wo100(
//     '1 Offer', 12, FontWeight.w700)
                                    ],
                                  ),
                                  SizedMedia.heightDivide(context, 100),
                                  Text(
                                    'Delivered by ${DateFormat('EEEE, MM d, yyyy').format(snapshotProduct!['deliveryDate'].toDate()).toString()}',
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
                                    'Quantity : ${productQuantity[widget.productIndex].toString()}',
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
                //productDetailsWidget(context),
                SizedMedia.heightDivide(context, 60),
                Text(
                  'Select Refund Type',
                  style: AppText.montserrat60016pxb000000,
                ),
                Divider(
                  color: AppColor.gF1F1F1w78,
                ),
                refundTypeCheckBoxWidget(context, upi, () {
                  setState(() {
                    upi = true;
                    wallet = false;
                    bank = false;
                    card = false;
                  });
                }, 'UPI',
                    'Refund will be processed to your UPI within one day business day after pickup is completed'),
                Divider(
                  color: AppColor.gF1F1F1w78,
                ),
                refundTypeCheckBoxWidget(context, wallet, () {
                  setState(() {
                    upi = false;
                    wallet = true;
                    bank = false;
                    card = false;
                  });
                }, 'Wallet',
                    'Refund will be processed to your Wallet within one day business day after pickup is completed'),
                Divider(
                  color: AppColor.gF1F1F1w78,
                ),
                refundTypeCheckBoxWidget(context, bank, () {
                  setState(() {
                    upi = false;
                    wallet = false;
                    bank = true;
                    card = false;
                  });
                }, 'Bank Account',
                    'Refund will be processed to your Bank Account within one day business day after pickup is completed'),
                Divider(
                  color: AppColor.gF1F1F1w78,
                ),
                refundTypeCheckBoxWidget(context, card, () {
                  setState(() {
                    upi = false;
                    wallet = false;
                    bank = false;
                    card = true;
                  });
                }, 'Gift Card Or Voucher',
                    'Refund will be processed to your Gift Card Or Voucher within one day business day after pickup is completed'),
                Divider(
                  color: AppColor.gF1F1F1w78,
                ),
              ],
            ),
          ),
        ),
        bottomSheet: bottomSheetButton(context, () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BankDetails2(
                    upi: upi,
                    wallet: wallet,
                    bank: bank,
                    card: card,
                    orderId: widget.orderId,
                    productIndex: widget.productIndex,
                    reasonReturn: widget.reasonReturn,
                    details: widget.details,
                    imageFile: widget.imageFile,
                  )));
        }, 'Continue'),
      ),
    );
  }
}
