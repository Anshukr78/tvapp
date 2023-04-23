import 'dart:async';

import 'package:flutter/material.dart';

import '../../helper/text_style.dart';
import '../../helper/widgets/main_button_widget.dart';
import '../home_page/bottom_bar.dart';


class CancelSuccessful extends StatefulWidget {
  final String comment;
  const CancelSuccessful({Key? key, required this.comment}) : super(key: key);

  @override
  State<CancelSuccessful> createState() => _CancelSuccessfulState();
}

class _CancelSuccessfulState extends State<CancelSuccessful> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3), (() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => const BottomNavBarPage()),
        ),
      );
    }),);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/tick.png', height: 42, width: 42,),
            const SizedBox(height: 20,),
            Text(widget.comment,
              style: AppText.montserrat40012pxb000000w69,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: primaryButton(
                context: context,
                text: 'Go back to Home',
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context)=> const BottomNavBarPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
