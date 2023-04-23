import 'dart:async';

import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/helper/size.dart';
import 'package:harbour_ecommerce/helper/text_style.dart';

import '../../helper/widgets/main_button_widget.dart';
import '../home_page/bottom_bar.dart';


class SuccessFullPage extends StatefulWidget {
  const SuccessFullPage({Key? key}) : super(key: key);

  @override
  State<SuccessFullPage> createState() => _SuccessFullPageState();
}

class _SuccessFullPageState extends State<SuccessFullPage> {

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
            Text('Congratulations! \n Your order will be delivered soon',
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
