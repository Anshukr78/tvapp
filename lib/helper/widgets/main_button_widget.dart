import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/helper/widgets/text_style_widget.dart';

import '../consts.dart';

Widget primaryButton(
    {required BuildContext context,
    required String text,
    required VoidCallback onTap}) {
  return Container(
    decoration: BoxDecoration(
        gradient: kMyGradient, borderRadius: BorderRadius.circular(8)),
    child: ElevatedButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.transparent),

        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        // elevation: MaterialStateProperty.all(25),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: CustomText(
                text: text,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
