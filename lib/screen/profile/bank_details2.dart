import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

import '../../component/loading.dart';
import '../../helper/button.dart';
import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/check_box.dart';
import '../../widget/rectangle_widget.dart';
import '../address/cancel_successful.dart';

class BankDetails2 extends StatefulWidget {
  const BankDetails2(
      {super.key,
        required this.upi,
        required this.wallet,
        required this.bank,
        required this.card,
        required this.orderId,
        required this.productIndex,
        required this.reasonReturn,
        required this.details,
        required this.imageFile});
  final bool upi;
  final bool wallet;
  final bool bank;
  final bool card;
  final String orderId;
  final int productIndex;
  final String reasonReturn;
  final String details;
  final imageFile;

  @override
  State<BankDetails2> createState() => _BankDetails2State();
}

class _BankDetails2State extends State<BankDetails2> {

  bool loading = false;
  String profileImage='';
  var selectedItem;
  DocumentSnapshot? snapshotProduct, snapshotAddress;
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
    });
    getAddress();
  }

  void getAddress()async{

    snapshotAddress = await FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('address').doc(snapshotProduct!['address'])
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

  void uploadRefundValue()async{
      setState(() {
        loading = true;
      });

      var refundId = const Uuid().v4();

      storage.Reference reference = storage.FirebaseStorage.instance.ref().child('refunds').child(refundId);
      storage.UploadTask uploadTask = reference.putFile(File(widget.imageFile!.path));

      storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete((){
      });
      try{


        await taskSnapshot.ref.getDownloadURL().then((url) async{
          profileImage =url;
          CollectionReference orderReference = FirebaseFirestore.instance.collection('refunds');
          await orderReference.doc(refundId).set({
            'id' : refundId,
            'userId' : FirebaseAuth.instance.currentUser!.uid,
            'addressId' : snapshotProduct!['address'],
            'productId' : productId[widget.productIndex],
            'orderId' : widget.orderId,
            'productQuantity' : productQuantity[widget.productIndex],
            'productSize' : productSize[widget.productIndex],
            'refundAmount': snapshotProduct!['paidAmount'],
            'refundPaymentMethod' : widget.wallet ==  true ? 'Wallet' : widget.bank == true? 'Bank' : widget.card == true ? 'Card' : widget.upi == true ? 'UPI' : '',
            'reason' : widget.reasonReturn,
            'moreDetails' : widget.details,
            'returnImage' : profileImage,
            'refundRequestDate' : DateTime.now(),
            'refundCompleteDate' : '',
            'refundStatus' : 'Return Requested',
          });
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
                    'Returned',
                  });
            });

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CancelSuccessful(comment: 'Refund request \n has been created',)));

      }on FirebaseAuthException  catch(e){

        setState(() {
          loading = false;
        });
        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }catch(e){

        setState(() {
          loading = false;
        });

        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }finally{

        setState(() {
          loading = false;
        });

      }

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
                SizedMedia.heightDivide(context, 60),
                Text(
                  'Selected Refund Type',
                  style: AppText.montserrat60016pxb000000,
                ),
                widget.upi == true
                    ? refundTypeCheckBoxWidget(context, widget.upi, () {}, 'UPI',
                        'Refund will be processed to your UPI within three day business day after pickup is completed')
                    : widget.wallet == true
                        ? refundTypeCheckBoxWidget(
                            context,
                            widget.wallet,
                            () {},
                            'Wallet',
                            'Refund will be processed to your Wallet within two day business day after pickup is completed')
                        : widget.bank == true
                            ? refundTypeCheckBoxWidget(
                                context,
                                widget.bank,
                                () {},
                                'Bank Account',
                                'Refund will be processed to your Bank Account within one day business day after pickup is completed')
                            : refundTypeCheckBoxWidget(
                                context,
                                widget.card,
                                () {},
                                'Gift Card Or Voucher',
                                'Refund will be processed to your Gift Card Or Voucher within one day business day after pickup is completed'),
                SizedMedia.heightDivide(context, 20),
                Text(
                  'Pick Up Address',
                  style: AppText.montserrat60016pxb000000,
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
              ],
            ),
          ),
        ),
        bottomSheet: bottomSheetButton(context, () {
          uploadRefundValue();
        }, 'Send Request'),
      ),
    );
  }
}
