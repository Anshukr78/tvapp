
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/screen/address/successful.dart';
import 'package:harbour_ecommerce/screen/home_page/bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../component/loading.dart';
import '../../helper/button.dart';
import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../helper/widgets/main_button_widget.dart';
import '../../model/cartModel.dart';
import '../../widget/app_bar.dart';


class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {

  @override
  void initState() {
    getData();
    super.initState();
  }

  String? selectedPayment;
  bool isLoading = false;

  String? addressId;
  List quantity = [];
  List size = [];
  List productId = [];

  List<String> _paymentMethodString =[
    'PhonePe (UPI, Wallet)',
    'Credit / Debit / ATM Card',
    'Net Banking',
    'Cash on delivery',
    'EMI (Easy installments)'
  ];

  getData()async{

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      addressId = snapshot['shipping-address'][0];
    });

    var productList = Provider.of<Cart>(context, listen: false).getItems;

    for(int i =0; i< productList.length; i++){
      quantity.add(productList[i].qty);
      size.add(productList[i].size[0]);
      productId.add(productList[i].id);
      setState(() {
      });
    }
  }

  nextPageRoute(){
    switch(selectedPayment){
      case 'PhonePe (UPI, Wallet)':
       // Navigator.push(context, MaterialPageRoute(builder: (context)=> const SuccessFullPage()));
        break;
      case 'Credit / Debit / ATM Card':
       // Navigator.push(context, MaterialPageRoute(builder: (context)=> const SuccessFullPage()));
        break;
      case 'Net Banking':
       // Navigator.push(context, MaterialPageRoute(builder: (context)=> const SuccessFullPage()));
        break;
      case 'Cash on delivery':
        orderSubmit();
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> const SuccessFullPage()));
        break;
      case 'EMI (Easy installments)':
       // Navigator.push(context, MaterialPageRoute(builder: (context)=> const SuccessFullPage()));
        break;
      default :
        print('Please select someValue');
        break;
    }
  }

  orderSubmit(){
    showModalBottomSheet(context: context, builder: (context){
      return SizedBox(
        height: MediaQuery.of(context).size.height*0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Pay at home ₹ ${context.watch<Cart>().totalPrice.toStringAsFixed(2)}',
              style: AppText.montserrat60016pxb403C3C,
            ),
            isLoading ?  const LoadingScreen() :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: primaryButton(
                context: context,
                text: 'Confirm',
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  CollectionReference orderReference = FirebaseFirestore.instance.collection('orders');
                  var orderId = const Uuid().v4();

                  await orderReference.doc(orderId).set({
                    'id' : orderId,
                    'userId' : FirebaseAuth.instance.currentUser!.uid,
                    'address' : addressId,
                    'productList' : productId,
                    'productQuantity' : quantity,
                    // 'discount' : '',
                    // 'couponNumber':'',
                    'productSize' : size,
                    'orderStatus' : 'Ordered',
                    'orderDate' : DateTime.now(),
                    'totalAmount' : Provider.of<Cart>(context, listen: false).totalPrice,
                    'deliveryDate' : '',
                    'paidAmount': Provider.of<Cart>(context, listen: false).totalPrice,
                    'paymentMode' : selectedPayment,
                    'reason' : '',
                    'moreDetails' : '',
                    'returnImage' : [],
                  });

                  context.read<Cart>().clearCart();
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SuccessFullPage()));
                },
              ),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: otherAppBar(context, 'Payment method'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.widthDivide(context, 25),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      height: AppSize.heightDivide(context, 24),
                      width: AppSize.widthMultiply(context, 1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       'PhonePe (UPI, Wallet)',
                          //       style: AppText.montserrat60015pxg9E9E9E,
                          //     ),
                          //     SizedMedia.heightDivide(context, 140),
                          //     SizedBox(
                          //       width: AppSize.widthDivide(context, 1.53),
                          //       child: Text(
                          //         '${snapshot.data!.docs[index +1]['address']},${snapshot.data!.docs[index +1]['landmark']},${snapshot.data!.docs[index +1]['city']},${snapshot.data!.docs[index +1]['country']},${snapshot.data!.docs[index +1]['pincode']}',
                          //         style: AppText.montserrat60010pxg9E9E9E,
                          //       ),
                          //     ),
                          //     Text(
                          //       'phone number- ${snapshot.data!.docs[index +1]['phone_number']}',
                          //       style: AppText.montserrat60010pxg9E9E9E,
                          //     )
                          //   ],
                          // ),

                          Text(
                            _paymentMethodString[index],
                            style: selectedPayment == _paymentMethodString[index]
                                ? AppText.montserrat50014pxoFE9F00
                                : AppText.montserrat60015pxg9E9E9E,
                          ),
                          SizedMedia.widthDivide(context, 25),
                          Radio(
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              activeColor: AppColor.oFF8A00,
                              value: _paymentMethodString[index],
                              groupValue: selectedPayment,
                              onChanged: (value) {
                                setState(() {
                                  selectedPayment = value;
                                });
                              },
                          ),
                        ],
                      ),
                    );
                  },
                separatorBuilder: (context, index){
                    return Divider(
                      thickness: 1,
                      color: AppColor.gF1F1F1w78,
                    );
                  },
                itemCount: _paymentMethodString.length,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical:
                    AppSize.heightDivide(context, 160)),
                height: AppSize.heightDivide(context, 7.2072),
                width: AppSize.widthMultiply(context, 1),
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          'Price(${Provider.of<Cart>(context).getItems.length.toString()} item)',
                          style:
                          AppText.montserrat40012pxb000000,
                        ),
                        Text(
                          '₹ ${Provider.of<Cart>(context).totalPrice.toString()}',
                          style:
                          AppText.montserrat40012pxb000000,
                        ),
                      ],
                    ),
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
                          '₹ ${Provider.of<Cart>(context).totalPrice.toString()}',
                          style:
                          AppText.montserrat50012pxb000000,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
                    '₹ ${Provider.of<Cart>(context, listen: false).totalPrice.toString()}',
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
              isLoading ? const LoadingScreen() : button176(context, () {
                nextPageRoute();
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
