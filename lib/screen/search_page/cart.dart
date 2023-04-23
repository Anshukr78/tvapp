import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../helper/button.dart';
import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../helper/widgets/main_button_widget.dart';
import '../../model/cartModel.dart';
import '../../widget/app_bar.dart';
import '../../widget/cart_widget.dart';
import '../home_page/bottom_bar.dart';
import '../home_page/place_an_order/order_summary.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.wFAFAFA,
          appBar: otherAppBar(context, 'Cart'),

          body: context
              .watch<Cart>()
              .getItems
              .isNotEmpty ?
          Consumer<Cart>(builder: (context, cart, child) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: AppSize.widthDivide(context, 30),
                          vertical: AppSize.heightDivide(context, 60),
                        ),
                        height: AppSize.heightDivide(context, 5.7142),
                        width: AppSize.widthMultiply(context, 1),
                        child: Row(
                          children: [
                            Container(
                              height: AppSize.heightDivide(context, 5.7142),
                              width: AppSize.widthDivide(context, 2.6086),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(cart.getItems[index].imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedMedia.widthDivide(context, 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: AppSize.widthDivide(context, 2.5),
                                  child: Text(
                                    cart.getItems[index].productName,
                                    style: AppText.montserrat50012pxb000000w85,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedMedia.heightDivide(context, 60),
                                Text(
                                  cart.getItems[index].productPrice.toString(),
                                  style: AppText.montserrat50012pxb000000w85,
                                ),
                                SizedMedia.heightDivide(context, 80),
                                Container(
                                  padding: EdgeInsets.only(left: AppSize.widthDivide(context, 80)),
                                  height: AppSize.heightDivide(context, 44.444),
                                  width: AppSize.widthDivide(context, 4.7368),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(width: 0.5, color: AppColor.gC1C1C1)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Quantity:',
                                        style: AppText.montserrat40010pxb000000,
                                      ),
                                      Container(
                                        width: AppSize.widthDivide(context, 18),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(2),
                                            border: Border.all(width: 0.5, color: AppColor.gC1C1C1)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              cart.getItems[index].qty.toString(),
                                              style: AppText.montserrat40010pxb000000,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                    onTap: (){
                                                      cart.increment(cart.getItems[index]);
                                                    },
                                                    child: Icon(
                                                      Icons.expand_less,
                                                      color: AppColor.b000000,
                                                      size: AppSize.heightDivide(context, 100.7046),
                                                    )),
                                                InkWell(
                                                    onTap: cart.getItems[index].qty == 1 ?
                                                        (){
                                                      cart.removeItem(cart.getItems[index]);
                                                    }
                                                        :
                                                        (){
                                                      cart.reduceByOne(
                                                          cart.getItems[index]
                                                      );
                                                    },
                                                    child: Icon(
                                                      Icons.expand_more,
                                                      color: cart.getItems[index].qty == 1 ? AppColor.b000000w10 : AppColor.b000000,
                                                      size: AppSize.heightDivide(context, 100.7046),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: AppSize.widthDivide(context, 3),
                                    // left: AppSize.widthDivide(context, 7),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      cart.removeItem(cart.getItems[index]);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: AppColor.b000000,
                                      size: AppSize.heightDivide(context, 40.666),
                                    ),
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),
                      )
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: AppColor.b000000w10,
                    thickness: 1,
                  );
                },
                itemCount: cart.getItems.length,
              ),
            );
          },
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Cart is empty! \n Please add items in you cart',
                style: GoogleFonts.notoSerif(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: primaryButton(
                  context: context,
                  text: 'Continue Shopping',
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context)=> const BottomNavBarPage()));
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
            ],
          ),
          bottomSheet: context
              .watch<Cart>()
              .getItems
              .isNotEmpty ?bottomSheetButton(context, () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) {
                  return const OrderSummary();
                })));
          }, 'PROCEED TO BUY (${context.read<Cart>().totalPrice})') : SizedBox(),
      ),
    );
  }
}
