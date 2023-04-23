import 'package:flutter/material.dart';

import '../../helper/colors.dart';
import '../../widget/app_bar.dart';
import '../../widget/cart_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: otherAppBar(context, 'Wishlist'),
        // body: const SingleChildScrollView(
        //   child: CartWidget(),
        // ),
      ),
    );
  }
}
