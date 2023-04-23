import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/widget/rectangle_widget.dart';

import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';

class CartWidget extends StatefulWidget {
  final String imageUrl, productName;
  final int qty;
  final cart;
  final productPrice;

  const CartWidget({super.key, required this.imageUrl, required this.productName, required this.qty, required this.productPrice, required this.cart});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                image: NetworkImage(widget.imageUrl),
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
                  widget.productName,
                  style: AppText.montserrat50012pxb000000w85,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedMedia.heightDivide(context, 60),
              Text(
                widget.productPrice.toString(),
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
                            widget.qty.toString(),
                            style: AppText.montserrat40010pxb000000,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    widget.cart.increase();
                                    setState(() {

                                    });
                                  },
                                  child: Icon(
                                    Icons.expand_less,
                                    color: AppColor.b000000,
                                    size: AppSize.heightDivide(context, 100.7046),
                                  )),
                              InkWell(
                                  onTap: () {
                                    if(widget.qty == 1){

                                    }else{
                                      widget.cart.decrease();
                                      setState(() {

                                      });
                                    }
                                  },
                                  child: Icon(
                                    Icons.expand_more,
                                    color: AppColor.b000000,
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
    );
  }
}
