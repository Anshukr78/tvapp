import 'package:flutter/material.dart';

import '../../helper/button.dart';
import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_form_field.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/list_tile.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: otherAppBar(context, ''),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.heightDivide(context, 60),
              horizontal: AppSize.widthDivide(context, 25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.gradientFFB319wo100nFF8A00wo100(
                    'Contact Us', 18, FontWeight.w600),
                contactUsListTile(context, 'Call Us', '+345 678 67890'),
                contactUsListTile(context, 'Mail Us', 'fashioninsta@gmail.com'),
                contactUsListTile(
                    context, 'Address', 'street - full name ............'),
                SizedMedia.heightDivide(context, 60),
                AppText.gradientFFB319wo100nFF8A00wo100(
                    'GET IN TOUCH', 20, FontWeight.w600),
                SizedMedia.heightDivide(context, 60),
                contactUsTextForm(context, 'Subject', 16, 1),
                SizedMedia.heightDivide(context, 60),
                contactUsTextForm(context, 'Your Message', 7.3394, 6),
                SizedMedia.heightDivide(context, 40),
                button159(context, () {}, 'Submit'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
