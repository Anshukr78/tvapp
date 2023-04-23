import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/AuthScreens/register_page.dart';
import 'package:harbour_ecommerce/AuthScreens/third_party/login_type.dart';

import '../helper/alert_dilog.dart';
import '../helper/widgets/main_button_widget.dart';
import '../helper/widgets/text_field_widget.dart';
import '../helper/widgets/text_style_widget.dart';
import '../screen/home_page/bottom_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obsureText = true;
  bool loader = false;

  login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() {
        loader = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        final User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {


          //toaster

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavBarPage(),
            ),
          );

          setState(() {
            loader = false;
          });
        }
      } on FirebaseException catch (e) {
        setState(() {
          loader = false;
        });
        MyAlertDilaog.errorDialog(
            context: context,
            title: e.message.toString(),
            content: 'Something went wrong',
            tabNo: () {
              Navigator.pop(context);
            });
      } catch (e) {
        setState(() {
          loader = false;
        });
        MyAlertDilaog.errorDialog(
            context: context,
            title: e.toString(),
            content: 'Something went wrong',
            tabNo: () {
              Navigator.pop(context);
            });
      }
    } else {
      MyAlertDilaog.errorDialog(
        context: context,
        title: 'Please enter valid value',
        content: 'Enter correct email and password',
        tabNo: () {
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: const Color(0xfffbfbfa),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              const Center(
                child: CustomText(
                  text: 'Login',
                  weight: FontWeight.w600,
                  size: 24,
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              customTextField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  hintText: 'Phone number/ Email id'),
              SizedBox(
                height: size.height * 0.02,
              ),
              customTextField(
                  controller: passwordController,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsureText = !obsureText;
                      });
                    },
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                  obsureText: obsureText,
                  keyboardType: TextInputType.text,
                  hintText: 'Password'),
              SizedBox(
                height: size.height * 0.02,
              ),
              TextButton(
                onPressed: () {},
                child: const CustomText(
                  text: 'Forget Password?',
                  color: Colors.blueAccent,
                  weight: FontWeight.normal,
                  size: 12,
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              loader ? CircularProgressIndicator() : primaryButton(
                  context: context,
                  text: 'login',
                  onTap: () async {
                    login();

                    // try {
                    //   UserCredential userCredential = await FirebaseAuth.instance
                    //       .signInWithEmailAndPassword(
                    //           email: emailController.text,
                    //           password: passwordController.text);
                    //   print('loggedIn');
                    // } on FirebaseAuthException catch (e) {
                    //   if (e.code == 'user-not-found') {
                    //     print('No user found for that email.');
                    //   } else if (e.code == 'wrong-password') {
                    //     print('Wrong password provided for that user.');
                    //   }
                    // }
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
              const LoginType(),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: CustomText(
                        text: 'don\'t have account?',
                        size: 10,
                        color: Colors.black.withOpacity(0.78),
                      ),
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
                        },
                        child: CustomText(
                          text: ' Register',
                          size: 13,
                          color: Colors.black.withOpacity(0.78),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
