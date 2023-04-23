import 'package:flutter/material.dart';

import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';

class ReviewProductScreen extends StatefulWidget {
  const ReviewProductScreen({super.key});

  @override
  State<ReviewProductScreen> createState() => _ReviewProductScreenState();
}

class _ReviewProductScreenState extends State<ReviewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: cancelAppBar(context, 'Review Product'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedMedia.heightDivide(context, 60),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: AppSize.widthDivide(context, 25)),
                height: AppSize.heightDivide(context, 9.5238),
                width: AppSize.widthMultiply(context, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: AppSize.widthDivide(context, 5.625),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/bagpack.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: AppSize.widthMultiply(context, 0.7),
                          child: Text(
                            'Tokyo talkies slim fit women blue trousers',
                            style: AppText.montserrat60013pxb000000,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedMedia.heightDivide(context, 60),
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
                                  return LinearGradient(colors: [
                                    AppColor.oFFB319,
                                    AppColor.oFF8A00
                                  ]).createShader(rect);
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
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.5,
                color: AppColor.g9E9E9E,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: AppSize.heightDivide(context, 80),
                    horizontal: AppSize.widthDivide(context, 25)),
                height: AppSize.heightMultiply(context, 0.45),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'More detailed reviews get more visibility...',
                    hintStyle: AppText.montserrat50012pxg9E9E9E,
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.transparent,
                    )),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.transparent,
                    )),
                  ),
                  maxLines: 20,
                ),
              ),
              SizedMedia.heightDivide(context, 5),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSize.widthDivide(context, 30),
                    vertical: AppSize.heightDivide(context, 80)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo,
                            color: AppColor.b000000w85,
                            size: AppSize.heightDivide(context, 45),
                          ),
                          Text(
                            'Add image'.toUpperCase(),
                            style: AppText.montserrat50012pxb000000w85,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'skip and finish'.toUpperCase(),
                        style: AppText.montserrat50012pxb000000w85,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomSheet: Container(
          height: AppSize.heightDivide(context, 14.5148),
          width: AppSize.widthMultiply(context, 1),
          decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(width: 0.5, color: AppColor.g9E9E9E))),
        ),
      ),
    );
  }
}
