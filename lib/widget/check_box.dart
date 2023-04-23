import 'package:flutter/material.dart';

import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';

Widget refundTypeCheckBoxWidget(BuildContext context, bool valueName,
    Function call, String title, String subtitle) {
  return ListTile(
    minLeadingWidth: AppSize.widthDivide(context, 20),
    contentPadding: EdgeInsets.zero,
    leading: Container(
      height: AppSize.heightDivide(context, 44.444),
      width: AppSize.widthDivide(context, 20),
      decoration: valueName == true
          ? BoxDecoration(
              gradient:
                  LinearGradient(colors: [AppColor.oFFB319, AppColor.oFF8A00]))
          : null,
      child: Checkbox(
          side: BorderSide(color: AppColor.g9E9E9E, width: 2),
          activeColor: Colors.transparent,
          checkColor: AppColor.wFFFFFF,
          value: valueName,
          onChanged: (isSelected) {
            call();
          }),
    ),
    title: Text(
      title,
      style: AppText.montserrat50018pxb000000,
    ),
    subtitle: Text(
      subtitle,
      style: AppText.montserrat60010pxg9E9E9E,
    ),
  );
}

class RefundTypeCheckBox extends StatefulWidget {
  const RefundTypeCheckBox(
      {super.key,
      required this.upi,
      required this.wallet,
      required this.bank,
      required this.card});
  final bool upi;
  final bool wallet;
  final bool bank;
  final bool card;
  @override
  State<RefundTypeCheckBox> createState() => _RefundTypeCheckBoxState();
}

class _RefundTypeCheckBoxState extends State<RefundTypeCheckBox> {
  bool? upiValue;
  bool? walletValue;
  bool? bankValue;
  bool? cardValue;

  @override
  Widget build(BuildContext context) {
    setState(() {
      upiValue = widget.upi;
      walletValue = widget.wallet;
      bankValue = widget.bank;
      // cardValue=widget.card
    });
    return Column(
      children: [
        // Divider(
        //   color: AppColor.gF1F1F1w78,
        // ),
        // refundTypeCheckBoxWidget(context, widget.upi, () {
        //   setState(() {
        //     upi = true;
        //     wallet = false;
        //     bank = false;
        //     card = false;
        //   });
        // }, 'UPI',
        //     'Refund will be processed to your UPI within one day business day after pickup is completed'),
        // Divider(
        //   color: AppColor.gF1F1F1w78,
        // ),
        // refundTypeCheckBoxWidget(context, wallet, () {
        //   setState(() {
        //     upi = false;
        //     wallet = true;
        //     bank = false;
        //     card = false;
        //   });
        // }, 'Wallet',
        //     'Refund will be processed to your Wallet within one day business day after pickup is completed'),
        // Divider(
        //   color: AppColor.gF1F1F1w78,
        // ),
        // refundTypeCheckBoxWidget(context, bank, () {
        //   setState(() {
        //     upi = false;
        //     wallet = false;
        //     bank = true;
        //     card = false;
        //   });
        // }, 'Bank Account',
        //     'Refund will be processed to your Bank Account within one day business day after pickup is completed'),
        // Divider(
        //   color: AppColor.gF1F1F1w78,
        // ),
        // refundTypeCheckBoxWidget(context, card, () {
        //   setState(() {
        //     upi = false;
        //     wallet = false;
        //     bank = false;
        //     card = true;
        //   });
        // }, 'Gift Card Or Voucher',
        //     'Refund will be processed to your Gift Card Or Voucher within one day business day after pickup is completed'),
        // Divider(
        //   color: AppColor.gF1F1F1w78,
        // ),
      ],
    );
  }
}
