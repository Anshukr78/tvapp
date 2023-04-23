import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/screen/home_page/bottom_bar.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    Timer(const Duration(seconds: 3), (() {

      User? user = FirebaseAuth.instance.currentUser;

      if(user == null){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const OnBoardingScreen()),
          ),
        );
      }
      else{
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const BottomNavBarPage()),
          ),
        );
      }

    }),);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          const Spacer(),
          Center(
            child: Image.asset(
              'images/logoH.png',
              filterQuality: FilterQuality.high,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text('Terms And Conditions'),
          ),
          SizedBox(
            height: size.height * 0.01,
          )
        ],
      ),
    );
  }
}
