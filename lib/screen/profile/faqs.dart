import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';

class FAQs extends StatefulWidget {
  const FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  // ignore: prefer_typing_uninitialized_variables
  var selectedTile;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: otherAppBar(context, ''),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSize.heightDivide(context, 60),
            horizontal: AppSize.widthDivide(context, 25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.gradientFFB319wo100nFF8A00wo100(
                  'FAQS', 18, FontWeight.w600),
              Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  onExpansionChanged: (value) {
                    setState(() {
                      selectedTile = value;
                    });
                  },
                  trailing: ShaderMask(
                      child: Icon(
                        selectedTile == true ? CupertinoIcons.minus : Icons.add,
                        size: 20,
                        color: AppColor.wFFFFFF,
                      ),
                      shaderCallback: (border) {
                        // ignore: prefer_const_constructors
                        final Rect rect = Rect.fromLTRB(0, 0, 20, 20);
                        return LinearGradient(
                                colors: [AppColor.oFFB319, AppColor.oFF8A00])
                            .createShader(rect);
                      }),
                  tilePadding: EdgeInsets.zero,
                  title: Text(
                    'What is Try and Buy Service?',
                    style: selectedTile == true
                        ? AppText.montserrat60016pxb000000
                        : AppText.montserrat40016pxb000000,
                  ),
                  children: [
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus tincidunt vel nisi vitae tincidunt. Nulla eu nisl facilisis, auctor urna eu, porta lacus.',
                      style: AppText.montserrat40014pxb000000w45,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
