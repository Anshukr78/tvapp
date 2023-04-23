import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/helper/widgets/text_style_widget.dart';

import '../consts.dart';

Widget secondaryButton(
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              text: text,
            ),
            const Icon(
              Icons.navigate_next_outlined,
              color: Colors.black,
              size: 30,
            )
          ],
        ),
      ),
    ),
  );
}
