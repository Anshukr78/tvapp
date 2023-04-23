import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';

import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../widget/instruction_widget.dart';
import '../../widget/rectangle_widget.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({super.key});

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColor.b000000,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.widthDivide(context, 16),
                vertical: AppSize.heightDivide(context, 80)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                earnedRectangleWidget(context),
                SizedMedia.heightDivide(context, 20),
                AppText.gradientFFB319wo100nFF8A00wo100(
                    'How it works', 14, FontWeight.w600),
                SizedMedia.heightDivide(context, 20),
                instructionWidget(context, Icons.people, 'Invite your friends',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vestibulum magna vitae ante finibus volutpat.'),
                SizedMedia.heightDivide(context, 15),
                instructionWidget(
                    context,
                    Icons.shopping_bag_rounded,
                    'They place the order',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vestibulum magna vitae ante finibus volutpat.'),
                SizedMedia.heightDivide(context, 15),
                instructionWidget(
                    context,
                    Icons.shopping_bag_rounded,
                    'You redeem your reward',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vestibulum magna vitae ante finibus volutpat.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
