import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/AuthScreens/login_page.dart';
import 'package:harbour_ecommerce/AuthScreens/third_party/login_type.dart';
import 'package:harbour_ecommerce/AuthScreens/third_party/text_button.dart';
import 'package:harbour_ecommerce/helper/alert_dilog.dart';
import 'package:uuid/uuid.dart';

import '../../helper/widgets/main_button_widget.dart';
import '../../helper/widgets/text_field_widget.dart';
import '../../helper/widgets/text_style_widget.dart';
import '../component/loading.dart';
import '../helper/colors.dart';
import '../helper/widgets/secondary_button_widget.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final PageController _pageController = PageController();
  int indexValue = 0;
  bool loader = false;
  String? email;
  String? password;
  String? finalPassword;
  String? confirmPassword;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  getFinalPassword() {
    if (passwordController.text == confirmPasswordController.text) {
      return finalPassword = passwordController.text;
    }
    else {
      if (kDebugMode) {
        print('password did\'t match');
      }
    }
    setState(() {});
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();


  signUp()async{

    if(firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty){

      if(phoneController.text.isNotEmpty && emailController.text.isNotEmpty){

        if( passwordController.text.isNotEmpty && passwordController.text.length > 5){

          if(passwordController.text.length == confirmPasswordController.text.length){

            setState(() {
              loader = true;
            });
            try{
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim()
              );
              final User? user = FirebaseAuth.instance.currentUser;
              if(user != null){
                final uId = user.uid;
                final keyValue = Uuid().v4();
                user.updateDisplayName(firstNameController.text.trim());
                user.reload();

                await FirebaseFirestore.instance.collection('users').doc(uId).set({
                  'id' : uId,
                  'first_name' : firstNameController.text.trim(),
                  'last_name' : lastNameController.text.trim(),
                  'phone_number' : phoneController.text.trim(),
                  'email' : emailController.text.toLowerCase(),
                  'shipping-address' : [],
                  'mobile' : '+91${phoneController.text}',
                  'userWish' : [],
                  'userCart' : [],
                  'createdAt' : Timestamp.now(),
                });

                await FirebaseFirestore.instance.collection('users').doc(uId).collection('address').doc(keyValue).set({
                  'id' : keyValue,
                  'first_name' : '',
                  'last_name' : '',
                  'phone_number':'',
                  'address':'',
                  'landmark' : '',
                  'city' :'',
                  'country' : '',
                  'pincode' : '',
                  'lat' : '',
                  'long' : '',
                });

                setState(() {
                  loader = false;
                });
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
              }


            } on FirebaseException catch(e){

              MyAlertDilaog.errorDialog(
                  context: context,
                  title: e.message.toString(),
                  content: 'Something went wrong',
                  tabNo: (){
                    Navigator.pop(context);
                  }
              );

              setState(() {
                loader = false;
              });

            }catch(e){

              MyAlertDilaog.errorDialog(
                  context: context,
                  title: e.toString(),
                  content: 'Something went wrong',
                  tabNo: (){
                    Navigator.pop(context);
                  }
              );
              setState(() {
                loader = false;
              });
            }

          }
          else{
            //password must be equal
            MyAlertDilaog.errorDialog(
              context: context,
              title: 'Password and confirm-password must be equal',
              content: 'Please match both passwords',
              tabNo: (){
                Navigator.pop(context);
              },
            );
          }

        }
        else{

          //length of password
          MyAlertDilaog.errorDialog(
            context: context,
            title: 'Please enter valid password',
            content: 'Password length must be more than 6 letter',
            tabNo: (){
              Navigator.pop(context);
            },
          );
        }

      }
      else{
        //phone and email
        MyAlertDilaog.errorDialog(
          context: context,
          title: 'Please fill phone number and email',
          content: 'All fields are mandatory',
          tabNo: (){
            _pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn);

            Navigator.pop(context);
          },
        );

      }

    }
    else{
      //firstname and last name

      MyAlertDilaog.errorDialog(
          context: context,
          title: 'Please fill First name and Last name',
          content: 'All fields are mandatory',
          tabNo: (){
            _pageController.animateToPage(
                 0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn);

            Navigator.pop(context);
          },
      );

    }

  }


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              PageView(

                onPageChanged: (value){
                  setState(() {
                    indexValue = value;
                  });
                },

                controller: _pageController,

                //physics: const NeverScrollableScrollPhysics(),
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        const Center(
                          child: CustomText(
                            text: 'Register',
                            weight: FontWeight.w600,
                            size: 24,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        customTextField(
                            controller: firstNameController,
                            keyboardType: TextInputType.text,
                            hintText: 'Your First Name'),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        customTextField(
                            controller: lastNameController,
                            keyboardType: TextInputType.text,
                            hintText: 'Your Last Name'),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            secondaryButton(
                                context: context,
                                text: 'Next',
                                onTap: () {
                                  _pageController.animateToPage(
                                      _pageController.page!.toInt() + 1,
                                      duration: const Duration(milliseconds: 200),
                                      curve: Curves.easeIn);
                                }),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        const CustomText(
                          text: 'Or',
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                          size: 12,
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        LoginType(),

                        SizedBox(
                          height: size.height * 0.10,
                        ),

                        TextButtonWidgetRich(),

                        SizedBox(
                          height: size.height * 0.02,
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        const Center(
                          child: CustomText(
                            text: 'Register',
                            weight: FontWeight.w600,
                            size: 24,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        customTextField(
                            controller: phoneController,
                            keyboardType: TextInputType.text,
                            hintText: 'Phone Number'),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        customTextField(
                            controller: emailController,
                            keyboardType: TextInputType.text,
                            hintText: 'Enter Your Email'),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            secondaryButton(
                                context: context,
                                text: 'Next',
                                onTap: () {
                                  _pageController.animateToPage(
                                      _pageController.page!.toInt() + 1,
                                      duration: const Duration(milliseconds: 200),
                                      curve: Curves.easeOutExpo);
                                }),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        const CustomText(
                          text: 'Or',
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                          size: 12,
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),


                        const LoginType(),

                        SizedBox(
                          height: size.height * 0.10,
                        ),
                        const TextButtonWidgetRich(),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        const Center(
                          child: CustomText(
                            text: 'Register',
                            weight: FontWeight.w600,
                            size: 24,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        customTextField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            hintText: 'Create Your Password'),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        customTextField(
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.text,
                            hintText: 'Re-Enter Your Password'),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: CustomText(
                            text: '*Password Should Contain Atleast One  Uppercase',
                            size: 10,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: CustomText(
                            text: '*Password Length Should Be Of Minimum 6 Characters',
                            size: 10,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                        loader ? const LoadingScreen() : primaryButton(
                            context: context,
                            text: 'Sign In',
                            onTap: () async {
                              signUp();
                            },
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        const CustomText(
                          text: 'Or',
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                          size: 12,
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     Image.asset(
                        //       'images/google.png',
                        //       filterQuality: FilterQuality.high,
                        //     ),
                        //     Image.asset(
                        //       'images/fb.png',
                        //       filterQuality: FilterQuality.high,
                        //     ),
                        //     Image.asset(
                        //       'images/apple.png',
                        //       filterQuality: FilterQuality.high,
                        //     )
                        //   ],
                        // ),

                        // const Spacer(),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       height: 5,
                        //       width: 50,
                        //       decoration: BoxDecoration(
                        //         color: kGreyColor,
                        //         borderRadius: const BorderRadius.all(
                        //           Radius.circular(90),
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Container(
                        //       height: 5,
                        //       width: 50,
                        //       decoration: BoxDecoration(
                        //         color: kGreyColor,
                        //         borderRadius: const BorderRadius.all(
                        //           Radius.circular(90),
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Container(
                        //       height: 5,
                        //       width: 50,
                        //       decoration: BoxDecoration(
                        //         gradient: kMyGradient,
                        //         borderRadius: const BorderRadius.all(
                        //           Radius.circular(90),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        const LoginType(),

                        SizedBox(
                          height: size.height * 0.10,
                        ),
                        const TextButtonWidgetRich(),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                      ],
                    ),
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
                  height: 10,
                  activeColor: AppColor.oFE9F00w49,
                  index: indexValue,
                  color: AppColor.gD9D9D9,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
