import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';
import '../screen/home_page/home.dart';
import '../screen/profile/profile.dart';
import '../screen/search_page/cart.dart';
import '../screen/search_page/search.dart';

List<Map<String, dynamic>> mapList = [
  {
    'call': () {},
    'title': 'Home',
  },
  {
    'call': () {},
    'title': 'Search',
  },
  {
    'call': () {},
    'title': 'Profile',
  },
  {
    'call': () {},
    'title': 'Cart',
  },
  {
    'call': () {},
    'title': 'Log out',
  }
];

Widget searchDrawer(BuildContext context) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      bottomLeft: Radius.circular(20),
    ),
    child: Drawer(
      backgroundColor: AppColor.wFAFAFA,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: AppSize.heightDivide(context, 60),
              left: AppSize.widthDivide(context, 1.8),
              bottom: AppSize.heightDivide(context, 60),
            ),
            child: IconButton(
              padding: const EdgeInsets.all(1),
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.multiply,
                color: AppColor.oFE9F00,
                size: AppSize.heightDivide(context, 40),
              ),
            ),
          ),
          ...List.generate(mapList.length, (index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSize.widthDivide(context, 10)),
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const HomePage())));
                } else if (index == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const SearchPage())));
                } else if (index == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const Profile())));
                } else if (index == 3) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const CartScreen())));
                } else {}
              },
              title: Text(
                mapList[index]['title'],
                style: AppText.montserrat40016pxoFE9F00,
              ),
            );
          }),
        ],
      ),
    ),
  );
}
