import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harbour_ecommerce/helper/text_style.dart';
import 'package:harbour_ecommerce/screen/search_page/cart.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../helper/button.dart';
import '../helper/colors.dart';
import '../model/cartModel.dart';
import '../model/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductClass productClass;

  const ProductDetailsScreen({super.key, required this.productClass});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  List sizeOfProduct = [];
  int itemCount = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: button159(context, () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const CartScreen();
            },
          ),
        );
      }, "BUY NOW"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(widget.productClass.imageUrl),
                  fit: BoxFit.cover,
                  // colorFilter: ColorFilter.mode(
                  //   Colors.black.withOpacity(0.2),
                  //   BlendMode.darken,
                  // ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                widget.productClass.productName,
                                style: GoogleFonts.montserrat(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                  letterSpacing: 0.04,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                '\₹ ${widget.productClass.productPrice.toString()}',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  AppColor.oFFB319,
                                  AppColor.oFF8A00
                                ]
                            ),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                             GestureDetector(
                                onTap: (){
                                  if(itemCount >= 1){
                                    setState(() {
                                      itemCount = itemCount-1;
                                    });
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: itemCount == 0 ? AppColor.b403C3Cw50 : AppColor.b403C3C,
                                  radius: 15,
                                  child: Center(child: AppText.gradientFFB319wo100nFF8A00wo100('-', 20 , FontWeight.w800),),
                                ),
                              ),

                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: AppColor.b403C3C,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(child: AppText.gradientFFB319wo100nFF8A00wo100(itemCount.toString(), 16 , FontWeight.w600)),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    itemCount = itemCount+1;
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColor.b403C3C,
                                  radius: 15,
                                  child: Center(child: AppText.gradientFFB319wo100nFF8A00wo100('+', 20 , FontWeight.w800),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ...List.generate(
                          widget.productClass.size.length,
                          (index) => GestureDetector(
                            onTap: () {

                              setState(() {
                                if(sizeOfProduct.isEmpty){
                                  sizeOfProduct.add(widget.productClass.size[index]);
                                }else{
                                  sizeOfProduct.clear();
                                  sizeOfProduct.add(widget.productClass.size[index]);
                                }
                              });

                            },
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: sizeOfProduct.contains(widget.productClass.size[index]) ? BoxDecoration(
                                gradient: LinearGradient(colors:[
                                  AppColor.oFFB319, AppColor.oFF8A00
                                ]),
                                borderRadius: BorderRadius.circular(30.0),
                              ) : BoxDecoration(
                                color:  Colors.grey[200],
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Center(
                                child: sizeOfProduct.contains(widget.productClass.size[index]) ?  Text(
                                  widget.productClass.size[index],
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey[600],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ) : AppText.gradientFFB319wo100nFF8A00wo100(
                                    widget.productClass.size[index], 16,  FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        //
                        //
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Container(
                        //     width: 50.0,
                        //     height: 50.0,
                        //     decoration: BoxDecoration(
                        //       color: Colors.grey[200],
                        //       borderRadius: BorderRadius.circular(30.0),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         'S',
                        //         style: GoogleFonts.montserrat(
                        //           color: Colors.grey[600],
                        //           fontSize: 16.0,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Container(
                        //     width: 50.0,
                        //     height: 50.0,
                        //     decoration: BoxDecoration(
                        //       color: Colors.grey[200],
                        //       borderRadius: BorderRadius.circular(30.0),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         'M',
                        //         style: GoogleFonts.montserrat(
                        //           color: Colors.grey[600],
                        //           fontSize: 16.0,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Container(
                        //     width: 50.0,
                        //     height: 50.0,
                        //     decoration: BoxDecoration(
                        //       border:
                        //           Border.all(color: AppColor.oFF8A00, width: 2),
                        //       color: Colors.grey[200],
                        //       borderRadius: BorderRadius.circular(30.0),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         'L',
                        //         style: GoogleFonts.montserrat(
                        //           color: Colors.grey[600],
                        //           fontSize: 16.0,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Container(
                        //     width: 50.0,
                        //     height: 50.0,
                        //     decoration: BoxDecoration(
                        //       color: Colors.grey[200],
                        //       borderRadius: BorderRadius.circular(30.0),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         'XL',
                        //         style: GoogleFonts.montserrat(
                        //           color: Colors.grey[600],
                        //           fontSize: 16.0,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Container(
                        //     width: 50.0,
                        //     height: 50.0,
                        //     decoration: BoxDecoration(
                        //       color: Colors.grey[200],
                        //       borderRadius: BorderRadius.circular(30.0),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         'XXL',
                        //         style: GoogleFonts.montserrat(
                        //           color: Colors.grey[600],
                        //           fontSize: 16.0,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            children: [
                              Text('Product description', style: AppText.montserrat60012pxb403C3C,),
                              const SizedBox(height: 10.0),
                              widget.productClass.brand == 'G' ? Text(
                                'G',
                                style: GoogleFonts.cuprum(
                                    color: const Color(0xff473001),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                    fontSize: 20
                                ),
                              ) : Text(
                                'L.H',
                                style: GoogleFonts.damion(
                                    color: const Color(0xff473001),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                    fontSize: 20
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                          child: GestureDetector(
                            onTap: (){

                              if(context.read<Cart>()
                                  .getItems.firstWhereOrNull((element) =>
                              element.id == widget.productClass.id) != null
                              ){
                                ScaffoldMessenger.of(context).showSnackBar(

                                    SnackBar(
                                      content: AppText.gradientFFB319wo100nFF8A00wo100(
                                          'This item already in cart',
                                          15,
                                          FontWeight.w600
                                      ),
                                      backgroundColor: AppColor.b403C3C,
                                      behavior: SnackBarBehavior.floating,
                                    )
                                );
                              } else if(sizeOfProduct.isNotEmpty && itemCount > 0){
                                context.read<Cart>().addProduct(
                                    id: widget.productClass.id,
                                    productName: widget.productClass.productName,
                                    productPrice: widget.productClass.productPrice,
                                    qty: itemCount,
                                    brand: widget.productClass.brand,
                                    productUrl: widget.productClass.imageUrl,
                                    category: widget.productClass.category,
                                    productDescrition: widget.productClass.productDescrition,
                                    size: sizeOfProduct
                                );





                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Product is added in cart')
                                    )
                                );

                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Please select Size and Quantity')
                                    )
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColor.oFFB319,
                                        AppColor.oFF8A00
                                      ]
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Center(
                                child: Text('Add to card',
                                  style: AppText.montserrat40014pxg473001,
                                ),
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    widget.productClass.productDescrition,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

