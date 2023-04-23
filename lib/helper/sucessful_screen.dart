import 'dart:async';

import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/helper/text_style.dart';
import 'package:harbour_ecommerce/helper/widgets/main_button_widget.dart';

import '../screen/home_page/bottom_bar.dart';

class ScreenSucessfully extends StatefulWidget {
  const ScreenSucessfully({Key? key}) : super(key: key);

  @override
  State<ScreenSucessfully> createState() => _ScreenSucessfullyState();
}

class _ScreenSucessfullyState extends State<ScreenSucessfully> {

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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: size.height *0.30,),
          Image.asset('images/tick.png'),
          SizedBox(height: size.height *0.050,),
          AppText.gradientFFB319wo100nFF8A00wo100(
              'SUCCESS!', 28, FontWeight.w800),
          SizedBox(height: size.height *0.10,),
          Text('Congratulation! Your account \nhas been successfully created',
            style: AppText.montserrat40012pxb000000w69,),
          SizedBox(height: size.height *0.15,),
          primaryButton(
            context: context,
            text: 'Get Started',
            onTap: () async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>
                      const BottomNavBarPage()));
            },
          ),
        ],
      ),
    );
  }
}
