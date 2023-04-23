import 'package:flutter/material.dart';

import '../helper/button.dart';
import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';


Widget profileListTile(
    BuildContext context, Function call, String title, String digit) {
  return GestureDetector(
    onTap: () {
      call();
    },
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppText.gradientFFB319wo100nFF8A00wo100(title, 14, FontWeight.w600),
          Text(
            digit,
            style: AppText.montserrat60014pxb000000,
          )
        ],
      ),
    ),
  );
}

Widget contactUsListTile(BuildContext context, String title, String subtitle) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(
      title,
      style: AppText.montserrat60018pxb000000,
    ),
    subtitle: Text(
      subtitle,
      style: AppText.montserrat50014pxg9E9E9E,
    ),
  );
}

Widget addAddressListTile(BuildContext context, Function call) {
  return ListTile(
    onTap: () {
      call();
    },
    contentPadding:
        EdgeInsets.symmetric(horizontal: AppSize.widthDivide(context, 20)),
    leading: ShaderMask(
        child: Icon(
          Icons.add,
          size: 29,
          color: AppColor.wFFFFFF,
        ),
        shaderCallback: (border) {
          // ignore: prefer_const_constructors
          final Rect rect = Rect.fromLTRB(0, 0, 29, 29);
          return LinearGradient(
                  colors: [AppColor.oFFB319, AppColor.oFF8A00],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)
              .createShader(rect);
        }),
    title: AppText.gradientFFB319wo100nFF8A00wo100(
        'Add A New Address', 15, FontWeight.w600),
  );
}

// Widget addressRadioButtonListTile(BuildContext context, Widget leading) {
//   return RadioListTile(
//     leading: leading,
//     title: Text(
//       'John Kipling',
//       style: AppText.montserrat60015pxg9E9E9E,
//     ),
//     subtitle: Text(
//       '29, green valley,tower of liberty, new york, united states,46231 phone number- 7623456402',
//       style: AppText.montserrat60010pxg9E9E9E,
//     ),
//     trailing: button49(context, () {}),
//   );
// }

Widget addressRadioButtonListTile(BuildContext context, Widget radioButton) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: AppSize.widthDivide(context, 25),
    ),
    height: AppSize.heightDivide(context, 12),
    width: AppSize.widthMultiply(context, 1),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        radioButton,
        SizedMedia.widthDivide(context, 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'John Kipling',
              style: AppText.montserrat60015pxg9E9E9E,
            ),
            SizedMedia.heightDivide(context, 140),
            SizedBox(
              width: AppSize.widthDivide(context, 1.53),
              child: Text(
                '29, green valley,tower of liberty, new york, united states,46231',
                style: AppText.montserrat60010pxg9E9E9E,
              ),
            ),
            Text(
              'phone number- 7623456402',
              style: AppText.montserrat60010pxg9E9E9E,
            )
          ],
        ),
        button49(context, () {})
      ],
    ),
  );
}
