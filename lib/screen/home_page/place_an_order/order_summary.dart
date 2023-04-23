import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harbour_ecommerce/component/loading.dart';
import 'package:harbour_ecommerce/model/cartModel.dart';
import 'package:provider/provider.dart';

import '../../../helper/button.dart';
import '../../../helper/colors.dart';
import '../../../helper/size.dart';
import '../../../helper/text_style.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/bottom_sheets.dart';
import '../../../widget/rectangle_widget.dart';
import '../../address/payment_method.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  var indexAddress;
  bool loading = false;

  void getData() async {
    setState(() {
      loading = true;
    });

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      indexAddress = snapshot['shipping-address'];
      loading = false;
    });
  }

  getMonth(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return null;
    }
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: otherAppBar(context, 'Order Summary'),
        body: loading
            ? const LoadingScreen()
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSize.heightDivide(context, 60),
                    horizontal: AppSize.widthDivide(context, 25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DeliverAddressWidget(
                        selectedAddressIndex: indexAddress,
                      ),
                      // productDetailsWidget(context),
                      Consumer<Cart>(
                        builder: (context, cart, child) {
                          return Column(
                            children: [
                              ListView.builder(
                                itemCount: cart.getItems.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical:
                                          AppSize.heightDivide(context, 70),
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
                                              height: AppSize.heightDivide(
                                                  context, 20),
                                              width: AppSize.widthDivide(
                                                  context, 1.9047),
                                              child: Text(
                                                cart.getItems[index]
                                                    .productName,
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
                                                  cart.getItems[index].size
                                                      .toString(),
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
                                                cart.getItems[index].brand ==
                                                        'G'
                                                    ? Text(
                                                        'G',
                                                        style:
                                                            GoogleFonts.cuprum(
                                                          color: const Color(
                                                              0xff473001),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          letterSpacing: 0.2,
                                                        ),
                                                      )
                                                    : Text(
                                                        'L.H',
                                                        style:
                                                            GoogleFonts.damion(
                                                          color: const Color(
                                                              0xff473001),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          letterSpacing: 0.2,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            SizedMedia.heightDivide(
                                                context, 120),
                                            Row(
                                              children: [
                                                Text(
                                                  '\$ ${cart.getItems[index].productPrice.toString()}',
                                                  style: AppText
                                                      .montserrat60020pxb000000,
                                                ),
                                              ],
                                            ),
                                            SizedMedia.heightDivide(
                                                context, 100),
                                            Text(
                                              'Delivery By ${getMonth(DateTime.now().add(const Duration(days: 5)).month)} ${DateTime.now().add(const Duration(days: 5)).day}',
                                              style: AppText
                                                  .montserrat40012pxb000000,
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
                                                  image: NetworkImage(cart
                                                      .getItems[index]
                                                      .imageUrl),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: AppSize.widthDivide(
                                                      context, 80)),
                                              height: AppSize.heightDivide(
                                                  context, 44.444),
                                              width: AppSize.widthDivide(
                                                  context, 4.7368),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: AppColor.gC1C1C1)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Quantity:',
                                                    style: AppText
                                                        .montserrat40010pxb000000,
                                                  ),
                                                  Container(
                                                    width: AppSize.widthDivide(
                                                        context, 18),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color: AppColor
                                                                .gC1C1C1)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          cart.getItems[index]
                                                              .qty
                                                              .toString(),
                                                          style: AppText
                                                              .montserrat40010pxb000000,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  cart.increment(
                                                                      cart.getItems[
                                                                          index]);
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .expand_less,
                                                                  color: AppColor
                                                                      .b000000,
                                                                  size: AppSize
                                                                      .heightDivide(
                                                                          context,
                                                                          100.7046),
                                                                )),
                                                            InkWell(
                                                                onTap: cart.getItems[index]
                                                                            .qty ==
                                                                        1
                                                                    ? () {
                                                                        cart.removeItem(
                                                                            cart.getItems[index]);
                                                                      }
                                                                    : () {
                                                                        cart.reduceByOne(
                                                                            cart.getItems[index]);
                                                                      },
                                                                child: Icon(
                                                                  Icons
                                                                      .expand_more,
                                                                  color: cart.getItems[index].qty ==
                                                                          1
                                                                      ? AppColor
                                                                          .b000000w10
                                                                      : AppColor
                                                                          .b000000,
                                                                  size: AppSize
                                                                      .heightDivide(
                                                                          context,
                                                                          100.7046),
                                                                ))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical:
                                        AppSize.heightDivide(context, 80)),
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
                                          'Price(${cart.getItems.length.toString()} item)',
                                          style:
                                              AppText.montserrat40012pxb000000,
                                        ),
                                        Text(
                                          '₹ ${cart.totalPrice.toString()}',
                                          style:
                                              AppText.montserrat40012pxb000000,
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
                                          style:
                                              AppText.montserrat40012pxb000000,
                                        ),
                                        Text(
                                          'FREE',
                                          style:
                                              AppText.montserrat40012pxb000000,
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
                                          style:
                                              AppText.montserrat50012pxb000000,
                                        ),
                                        Text(
                                          '₹ ${cart.totalPrice.toString()}',
                                          style:
                                              AppText.montserrat50012pxb000000,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      //priceDetailsWidget(context),
                      // AppText.gradientFFB319wo100nFF8A00wo100(
                      //     'You will save 5 on this order', 12, FontWeight.w700),
                    ],
                  ),
                ),
              ),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.widthDivide(context, 25),
            vertical: AppSize.heightDivide(context, 100),
          ),
          height: AppSize.heightDivide(context, 9.0909),
          width: AppSize.widthMultiply(context, 1),
          color: AppColor.gF2F2F2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₹ ${Provider.of<Cart>(context).totalPrice.toString()}',
                    style: AppText.montserrat60020pxb000000,
                  ),
                  SizedMedia.heightDivide(context, 200),
                  // InkWell(
                  //   onTap: () {
                  //     price();
                  //   },
                  //   child: AppText.gradientFFB319wo100nFF8A00wo100(
                  //       'view price details', 12, FontWeight.w700),
                  // ),
                ],
              ),
              button176(
                context,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentMethod(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
