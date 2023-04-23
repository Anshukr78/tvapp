import 'package:flutter/material.dart';

import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';
import '../screen/profile/review_product.dart';


class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  updateFunction(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: AppSize.heightDivide(context, 60),
      ),
      height: AppSize.heightDivide(context, 6.1538),
      width: AppSize.widthMultiply(context, 1),
      child: Row(
        children: [
          Container(
            width: AppSize.widthDivide(context, 2.7692),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: const DecorationImage(
                image: AssetImage('images/bagpack.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedMedia.widthDivide(context, 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Deliver On ',
                    style: AppText.montserrat50012pxb000000w85,
                  ),
                  Text(
                    'May 16',
                    style: AppText.montserrat50012pxb000000w85,
                  ),
                ],
              ),
              SizedMedia.heightDivide(context, 80),
              SizedBox(
                width: AppSize.widthDivide(context, 2.5),
                child: Text(
                  'Product Name',
                  style: AppText.montserrat50012pxb000000w85,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedMedia.heightDivide(context, 80),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.star,
                      color: AppColor.gD9D9D9,
                      size: AppSize.heightDivide(context, 44.444),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.star,
                      color: AppColor.gD9D9D9,
                      size: AppSize.heightDivide(context, 44.444),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.star,
                      color: AppColor.gD9D9D9,
                      size: AppSize.heightDivide(context, 44.444),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.star,
                      color: AppColor.gD9D9D9,
                      size: AppSize.heightDivide(context, 44.444),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.star,
                      color: AppColor.gD9D9D9,
                      size: AppSize.heightDivide(context, 44.444),
                    ),
                  ),
                ],
              ),
              SizedMedia.heightDivide(context, 80),
              Text(
                'Rate This Product Now',
                style: AppText.montserrat50012pxb000000w85,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: AppSize.heightDivide(context, 10),
              // left: AppSize.widthDivide(context, 7),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColor.b000000,
                size: AppSize.heightDivide(context, 40.666),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ReviewOrderWidget extends StatefulWidget {
  const ReviewOrderWidget({super.key});

  @override
  State<ReviewOrderWidget> createState() => _ReviewOrderWidgetState();
}

class _ReviewOrderWidgetState extends State<ReviewOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: AppSize.heightDivide(context, 60),
      ),
      height: AppSize.heightDivide(context, 6.1538),
      width: AppSize.widthMultiply(context, 1),
      child: Row(
        children: [
          Container(
            width: AppSize.widthDivide(context, 2.7692),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: const DecorationImage(
                image: AssetImage('images/bagpack.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedMedia.widthDivide(context, 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Deliver On ',
                    style: AppText.montserrat50012pxb000000w85,
                  ),
                  Text(
                    'May 16',
                    style: AppText.montserrat50012pxb000000w85,
                  ),
                ],
              ),
              SizedMedia.heightDivide(context, 80),
              SizedBox(
                width: AppSize.widthDivide(context, 2.5),
                child: Text(
                  'Product Name',
                  style: AppText.montserrat50012pxb000000w85,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedMedia.heightDivide(context, 80),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: ShaderMask(
                      child: Icon(
                        Icons.star,
                        color: AppColor.wFFFFFF,
                        size: AppSize.heightDivide(context, 44.444),
                      ),
                      shaderCallback: (border) {
                        final Rect rect = Rect.fromLTRB(
                            0,
                            0,
                            AppSize.heightDivide(context, 44.444),
                            AppSize.heightDivide(context, 44.444));
                        return LinearGradient(
                                colors: [AppColor.oFFB319, AppColor.oFF8A00])
                            .createShader(rect);
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.star,
                      color: AppColor.gD9D9D9,
                      size: AppSize.heightDivide(context, 44.444),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.star,
                      color: AppColor.gD9D9D9,
                      size: AppSize.heightDivide(context, 44.444),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.star,
                      color: AppColor.gD9D9D9,
                      size: AppSize.heightDivide(context, 44.444),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.star,
                      color: AppColor.gD9D9D9,
                      size: AppSize.heightDivide(context, 44.444),
                    ),
                  ),
                ],
              ),
              SizedMedia.heightDivide(context, 80),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const ReviewProductScreen())));
                },
                child: Text(
                  'Write A Review',
                  style: AppText.montserrat70012pxb403C3C,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: AppSize.heightDivide(context, 10),
              // left: AppSize.widthDivide(context, 7),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColor.b000000,
                size: AppSize.heightDivide(context, 40.666),
              ),
            ),
          )
        ],
      ),
    );
  }
}
