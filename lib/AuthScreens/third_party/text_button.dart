import 'package:flutter/material.dart';

import '../../helper/widgets/text_style_widget.dart';
import '../login_page.dart';


class TextButtonWidgetRich extends StatefulWidget {
  const TextButtonWidgetRich({Key? key}) : super(key: key);

  @override
  State<TextButtonWidgetRich> createState() => _TextButtonWidgetRichState();
}

class _TextButtonWidgetRichState extends State<TextButtonWidgetRich> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: CustomText(
              text: 'Already have an account?',
              size: 10,
              color: Colors.black.withOpacity(0.78),
            ),
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
              },
              child: CustomText(
                text: ' Login',
                size: 13,
                color: Colors.black.withOpacity(0.78),
              ),
            ),
          )
        ],
      ),
    );
  }
}
