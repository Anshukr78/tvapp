import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harbour_ecommerce/model/product.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';

import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';
import '../model/cartModel.dart';
import '../screen/product_details_screen.dart';


class HomeGridViewBox extends StatefulWidget {
  final ProductClass productClass;
  const HomeGridViewBox({Key? key, required this.productClass}) : super(key: key);

  @override
  State<HomeGridViewBox> createState() => _HomeGridViewBoxState();
}

class _HomeGridViewBoxState extends State<HomeGridViewBox> {

  List sizeOfProduct = [];
  bool valueCheck122 = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.heightDivide(context, 3.3),
      width: AppSize.widthDivide(context, 2.5899),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: AppSize.heightDivide(context, 4.0201),
                width: AppSize.widthDivide(context, 2.5899),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.productClass.imageUrl),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                right: 6,
                bottom: 7,
                child: InkWell(
                  onTap: () {
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
                    }else{

                      showDialog(
                          context: context,
                          builder: (context){
                            return StatefulBuilder(
                              builder: (context, setState){
                                return AlertDialog(
                                  title: Text('Please select size'),
                                  content: SizedBox(
                                    width: MediaQuery.of(context).size.width * 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        ...List.generate(
                                          widget.productClass.size.length,
                                              (index) => GestureDetector(
                                            onTap: () {
                                              print('Iansns');
                                              setState(() {
                                                if(sizeOfProduct.isEmpty){
                                                  sizeOfProduct.add(widget.productClass.size[index]);
                                                }else{
                                                  sizeOfProduct.clear();
                                                  sizeOfProduct.add(widget.productClass.size[index]);
                                                }
                                              });
                                              setState(() {
                                                valueCheck122 = sizeOfProduct.contains(widget.productClass.size[index]);
                                              });

                                              print(sizeOfProduct);
                                            },
                                            child: Container(
                                              width: 25.0,
                                              height: 25.0,
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
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ) : AppText.gradientFFB319wo100nFF8A00wo100(
                                                    widget.productClass.size[index], 12,  FontWeight.w500),
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
                                  actions: [
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 65,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: AppColor.b403C3C,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                                          child: Center(child: AppText.gradientFFB319wo100nFF8A00wo100('Cancel', 12 , FontWeight.w600)),
                                        ),
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap:(){

                                        if(sizeOfProduct.isNotEmpty){
                                          context.read<Cart>().addProduct(
                                              id: widget.productClass.id,
                                              productName: widget.productClass.productName,
                                              productPrice: widget.productClass.productPrice,
                                              qty: 1,
                                              brand: widget.productClass.brand,
                                              productUrl: widget.productClass.imageUrl,
                                              category: widget.productClass.category,
                                              productDescrition: widget.productClass.productDescrition,
                                              size: sizeOfProduct
                                          );

                                          Navigator.pop(context);

                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                  content: Text('Product is added in cart')
                                              )
                                          );

                                        }
                                        else{
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                  content: Text('Please select Size')
                                              )
                                          );
                                        }

                                      },
                                      child: Container(
                                        width: 60,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  AppColor.oFFB319,
                                                  AppColor.oFF8A00
                                                ]
                                            ),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Center(child: Text('Ok', style: AppText.montserrat40014pxg473001,)),
                                      ),
                                    ),
                                  ],
                                );
                              },

                            );
                          }
                      );

                    }
                  },
                  child: Iconify(
                    Ic.outline_add_circle,
                    size: AppSize.widthDivide(context, 17),
                    color: AppColor.b000000,
                  ),
                ),
              ),
            ],
          ),
          SizedMedia.heightDivide(context, 120),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.widthDivide(context, 50)),
            child: Row(
              children: [
                SizedBox(
                  width: AppSize.widthDivide(context, 4),
                  child: Text(
                    widget.productClass.productName,
                    style: AppText.montserrat50012pxb000000w85,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedMedia.widthDivide(context, 50),
                widget.productClass.brand == 'G' ?
                Text(
                  'G',
                  style: GoogleFonts.cuprum(
                    color: const Color(0xff473001),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ) :
                Text(
                  'L.H',
                  style: GoogleFonts.damion(
                    color: const Color(0xff473001),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: AppSize.widthDivide(context, 50)),
            child: Text(
              widget.productClass.productPrice.toString(),
              style: AppText.montserrat50012pxb000000w85,
            ),
          )
        ],
      ),
    );
  }
}



Widget homeGridViewBox({
  required BuildContext context,
  required ProductClass productClass
}) {

  List sizeOfProduct = [];

  return Container(
    height: AppSize.heightDivide(context, 3.3),
    width: AppSize.widthDivide(context, 2.5899),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: AppSize.heightDivide(context, 4.0201),
              width: AppSize.widthDivide(context, 2.5899),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(productClass.imageUrl),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              right: 6,
              bottom: 7,
              child: InkWell(
                onTap: () {
                  if(context.read<Cart>()
                      .getItems.firstWhereOrNull((element) =>
                  element.id == productClass.id) != null
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
                  }else{

                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text('Please select size'),
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  ...List.generate(
                                    productClass.size.length,
                                        (index) => GestureDetector(
                                      onTap: () {

                                      },
                                      child: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            productClass.size[index],
                                            style: GoogleFonts.montserrat(
                                              color: Colors.grey[600],
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
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
                          );
                        }
                    );


                    context.read<Cart>().addProduct(
                        id: productClass.id,
                        productName: productClass.productName,
                        productPrice: productClass.productPrice,
                        qty: 1,
                        brand: productClass.brand,
                        productUrl: productClass.imageUrl,
                        category: productClass.category,
                        productDescrition: productClass.productDescrition,
                        size: ['L']
                    );
                  }
                },
                child: Iconify(
                  Ic.outline_add_circle,
                  size: AppSize.widthDivide(context, 17),
                  color: AppColor.b000000,
                ),
              ),
            ),
          ],
        ),
        SizedMedia.heightDivide(context, 120),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.widthDivide(context, 50)),
          child: Row(
            children: [
              SizedBox(
                width: AppSize.widthDivide(context, 4),
                child: Text(
                  productClass.productName,
                  style: AppText.montserrat50012pxb000000w85,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedMedia.widthDivide(context, 50),
              productClass.brand == 'G' ? Text(
                'G',
                style: GoogleFonts.cuprum(
                  color: const Color(0xff473001),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ) : Text(
                'L.H',
                style: GoogleFonts.damion(
                  color: const Color(0xff473001),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: AppSize.widthDivide(context, 50)),
          child: Text(
            productClass.productPrice.toString(),
            style: AppText.montserrat50012pxb000000w85,
          ),
        )
      ],
    ),
  );
}





Widget searchGridViewBox({
  required BuildContext context,
  required String imageUrl,
  required String title,
  required String price,
  required String description,
  required String brand
}) {
  return SizedBox(
    height: AppSize.heightDivide(context, 4),
    width: AppSize.widthDivide(context, 2.5899),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: AppSize.heightDivide(context, 4.5),
          width: AppSize.widthDivide(context, 2.5899),
          decoration: BoxDecoration(
              color: AppColor.b000000w10,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
              ),
          ),
        ),
        SizedMedia.heightDivide(context, 120),
        Row(
          children: [
            SizedMedia.widthDivide(context, 50),
            SizedBox(
              width: AppSize.widthDivide(context, 4),
              child: Text(
                title,
                style: AppText.montserrat50012pxb000000w85,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedMedia.widthDivide(context, 12),
            brand == 'G' ? Text(
              'G',
              style: GoogleFonts.cuprum(
                color: const Color(0xff473001),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ) : Text(
              'L.H',
              style: GoogleFonts.damion(
                color: const Color(0xff473001),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: AppSize.widthDivide(context, 50)),
          child: Text(
            price,
            style: AppText.montserrat50012pxb000000w85,
          ),
        )
      ],
    ),
  );
}

Widget searchContentGridViewBox(BuildContext context) {
  return Container(
    height: AppSize.heightDivide(context, 7.9207),
    width: AppSize.widthDivide(context, 2.5899),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      image: const DecorationImage(
        image: AssetImage('images/bagpack.jpg'),
        fit: BoxFit.cover,
      ),
    ),
  );
}
