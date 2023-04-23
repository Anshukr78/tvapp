import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';

class ReturnDropdownButton extends StatefulWidget {
  const ReturnDropdownButton({super.key});

  @override
  State<ReturnDropdownButton> createState() => _ReturnDropdownButtonState();
}

class _ReturnDropdownButtonState extends State<ReturnDropdownButton> {
  // ignore: prefer_typing_uninitialized_variables
  var selectedItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: AppSize.heightDivide(context, 100)),
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
            buttonHeight: AppSize.heightDivide(context, 18.6046),
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
                  value: 'reason1',
                  child: Text(
                    'Item or product defective',
                    style: AppText.montserrat40012pxb000000,
                  )),
              DropdownMenuItem(
                  value: 'reason2',
                  child: Text(
                    'Item or product defective',
                    style: AppText.montserrat40012pxb000000,
                  )),
            ]),
      ),
    );
  }
}
