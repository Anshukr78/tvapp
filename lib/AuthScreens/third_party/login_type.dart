import 'package:flutter/material.dart';



class LoginType extends StatefulWidget {
  const LoginType({Key? key}) : super(key: key);

  @override
  State<LoginType> createState() => _LoginTypeState();
}

class _LoginTypeState extends State<LoginType> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () async {
            print('clicked');
          },
          child: Image.asset(
            'images/google.png',
            filterQuality: FilterQuality.high,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            'images/fb.png',
            filterQuality: FilterQuality.high,
          ),
        ),
        Image.asset(
          'images/apple.png',
          filterQuality: FilterQuality.high,
        )
      ],
    );
  }
}
