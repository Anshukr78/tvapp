import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/AuthScreens/register_page.dart';

import 'AuthScreens/login_page.dart';
import 'helper/colors.dart';
import 'helper/consts.dart';
import 'helper/widgets/main_button_widget.dart';
import 'helper/widgets/text_style_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  int indexValue = 0;

  @override
  Widget build(BuildContext context) {

    var text = RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: <TextSpan>[
          TextSpan(
            children: [
              WidgetSpan(
                child: CustomText(
                  text: 'welcome to ',
                ),
              ),
              WidgetSpan(
                child: CustomText(
                  text: 'harbour london',
                  color: Colors.orange,
                ),
              ),
              WidgetSpan(
                child: CustomText(
                  text: ', you are one click away to make shopping easier',
                ),
              )
            ],
          ),
        ],
      ),
    );

    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfffbfbfa),
      body: Stack(
        children: [

          PageView(
            onPageChanged: (value){
              setState(() {
                indexValue = value;
              });
            },
            children: [
              //OB 1
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'images/ob1.png',
                            filterQuality: FilterQuality.high,
                            height: size.height * 0.5,
                          ),
                          const CustomText(
                            text:
                            'Now you don\'t have to spend hours going through different stores',
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              //OB 2
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'images/ob2.png',
                            filterQuality: FilterQuality.high,
                            height: size.height * 0.5,
                          ),
                          const CustomText(
                            text:
                            'Sit in comfort of your home and enjoy shopping at your own place',
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              //OB 3
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          RotatedBox(
                            quarterTurns: 2,
                            child: Container(
                              height: size.height * 0.4,
                              decoration: BoxDecoration(gradient: kMyGradient),
                              child: const RotatedBox(
                                quarterTurns: 2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CustomText(
                                    text: 'Let\'s Get Us Started',
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.2,
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 50,
                        left: 1,
                        right: 1,
                        child: CircleAvatar(
                          radius: size.height * 0.13,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'images/cat.png',
                            height: size.height * 0.15,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                    ],
                  ),
                  text,
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(25),
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        shadowColor: MaterialStateProperty.all(
                          Colors.black.withOpacity(0.7),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginPage();
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: CustomText(
                                text: 'login',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: primaryButton(
                      context: context,
                      text: 'register',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const RegisterPage();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),

          Positioned(
            bottom: 50,
            left: 120,
            child: CarouselIndicator(
              count: 3,
              width: 50,
              space: 10,
              height: 3,
              activeColor: AppColor.oFE9F00w49,
              index: indexValue,
              color: AppColor.gD9D9D9,
            ),
          ),

        ],
      ),
    );
  }
}
