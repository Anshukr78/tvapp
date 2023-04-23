import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../component/loading.dart';
import '../../helper/button.dart';
import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_form_field.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/dropdown_button.dart';
import '../../widget/rectangle_widget.dart';
import 'bank_details.dart';

class ReturnRefund extends StatefulWidget {
  final String orderId;
  final int productIndex;

  const ReturnRefund(
      {super.key, required this.orderId, required this.productIndex});

  @override
  State<ReturnRefund> createState() => _ReturnRefundState();
}

class _ReturnRefundState extends State<ReturnRefund> {
  XFile? imageFile;
  final ImagePicker image = ImagePicker();

  Future<void> _getImage() async{
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Pick your image',
              textAlign: TextAlign.center,
              style: AppText.montserrat60020pxb403C3C,
            ),
            content: SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                        onTap: () async {

                          imageFile = await image.pickImage(source: ImageSource.camera);
                          setState((){
                            imageFile;
                          });

                          Navigator.pop(context);

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
                                  5),
                              color: AppColor.gF5F5F5),
                          //padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(
                              right: 10),
                          child: Center(
                              child: Icon(
                                Icons.camera_alt,
                                color: AppColor.g9E9E9E,
                                size: 30,
                              )),
                        ),
                      )),
                  Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          imageFile =
                          await image.pickImage(
                              source: ImageSource
                                  .gallery);
                          setState(() {});

                          imageFile = await image.pickImage(source: ImageSource.gallery);
                          setState((){
                            imageFile;
                          });

                          Navigator.pop(context);

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
                                  5),
                              color: AppColor.gF5F5F5),
                          // padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(
                              left: 10),
                          child: Center(
                            child: Icon(
                              CupertinoIcons
                                  .photo_fill_on_rectangle_fill,
                              color: AppColor.g9E9E9E,
                              size: 30,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        });
  }

  bool loading = false;
  var selectedItem;
  DocumentSnapshot? snapshotProduct;

  var productId, productSize, productQuantity, deliveryDate;
  TextEditingController controller = TextEditingController();

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
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: otherAppBar(context, ''),
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
                      AppText.gradientFFB319wo100nFF8A00wo100(
                          'Return/Refund', 18, FontWeight.w600),
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
                      Padding(
                        padding: EdgeInsets.only(
                            left: AppSize.widthDivide(context, 1.7)),
                        child: InkWell(
                          onTap: () {},
                          child: AppText.gradientFFB319wo100nFF8A00wo100(
                              'View Return Policy', 12, FontWeight.w700),
                        ),
                      ),
                      SizedMedia.heightDivide(context, 100),
                      Text(
                        'Return Request Details',
                        style: AppText.montserrat60014pxb000000,
                      ),
                      SizedMedia.heightDivide(context, 80),
                      Text(
                        'Reason for return',
                        style: AppText.montserrat50012pxg9E9E9E,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.heightDivide(context, 100)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                              buttonPadding: EdgeInsets.symmetric(
                                horizontal: AppSize.widthDivide(context, 36),
                              ),
                              dropdownWidth: AppSize.widthMultiply(context, 1),
                              buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.gF5F5F5),
                              // dropdownMaxHeight: AppSize.heightDivide(context, 18.6046),
                              buttonHeight:
                                  AppSize.heightDivide(context, 18.6046),
                              buttonWidth: AppSize.widthMultiply(context, 1),
                              value: selectedItem,
                              hint: Text(
                                '--select--',
                                style: AppText.montserrat40012pxb000000,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedItem = value;
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                    value: 'Item or product defective',
                                    child: Text(
                                      'Item or product defective',
                                      style: AppText.montserrat40012pxb000000,
                                    )),
                                DropdownMenuItem(
                                    value: 'Wrong item delivered',
                                    child: Text(
                                      'Wrong item delivered',
                                      style: AppText.montserrat40012pxb000000,
                                    )),
                                DropdownMenuItem(
                                    value: 'No longer required',
                                    child: Text(
                                      'No longer required',
                                      style: AppText.montserrat40012pxb000000,
                                    )),
                                DropdownMenuItem(
                                    value: 'Change the size of the item',
                                    child: Text(
                                      'Change the size of the item',
                                      style: AppText.montserrat40012pxb000000,
                                    )),
                              ]),
                        ),
                      ),
                      Text(
                        'More Details',
                        style: AppText.montserrat50012pxg9E9E9E,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: AppSize.heightDivide(context, 100),
                        ),
                        height: AppSize.heightDivide(context, 7.1428),
                        width: AppSize.widthMultiply(context, 1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColor.gF5F5F5),
                        child: TextFormField(
                          controller: controller,
                          style: AppText.montserrat40012pxb000000,
                          maxLines: 7,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: AppSize.heightDivide(context, 150),
                              horizontal: AppSize.widthDivide(context, 50),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                )),
                          ),
                        ),
                      ),
                      Text(
                        'Add Image Or A Video',
                        style: AppText.montserrat50012pxg9E9E9E,
                      ),
                      InkWell(
                        onTap: () async {
                          _getImage();
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: AppSize.heightDivide(context, 100),
                            ),
                            height: AppSize.heightDivide(context, 7.1428),
                            width: AppSize.widthMultiply(context, 1),
                            decoration: BoxDecoration(
                              image: imageFile == null ? null : DecorationImage(image: FileImage(File(imageFile!.path))),
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.gF5F5F5),
                            child: imageFile == null
                                ? Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Iconify(
                                      Ic.outline_add_box,
                                      color: AppColor.g9E9E9E,
                                    ),
                                  )
                                : null
                        ),
                      )
                    ],
                  ),
                ),
              ),
        bottomSheet: bottomSheetButton(context, () {
          if(selectedItem != null && imageFile != null && controller.text.isNotEmpty){
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (
                            (context) =>
                            BankDetails(
                              orderId: widget.orderId,
                              productIndex: widget.productIndex,
                              reasonReturn: selectedItem,
                              details: controller.text.trim(),
                              imageFile: imageFile,))));
          }else{
            ScaffoldMessenger.of(context).showSnackBar(

                SnackBar(
                  content: AppText.gradientFFB319wo100nFF8A00wo100(
                      'Please fill empty fields',
                      15,
                      FontWeight.w600
                  ),
                  backgroundColor: AppColor.b403C3C,
                  behavior: SnackBarBehavior.floating,
                )
            );
          }
        }, 'Continue'),
      ),
    );
  }
}
