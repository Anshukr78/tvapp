import 'package:flutter/material.dart';

import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../new_search.dart';
import 'home.dart';
import '../profile/profile.dart';
import '../search_page/search.dart';

// class BottomBar extends StatefulWidget {
//   const BottomBar({super.key});

//   @override
//   State<BottomBar> createState() => _BottomBarState();
// }

// class _BottomBarState extends State<BottomBar> {
//   List pages = [
//     Center(child: Text('search Page')),
//     const HomePage(),
//     Center(child: Text('profile Page')),
//   ];

//   int selectedIndex = 1;
//   void onItemTapped(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: selectedIndex,
//         onTap: onItemTapped,
//         items: [
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: selectedIndex == 1
//                 ? const Icon(Icons.home)
//                 : const Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: selectedIndex == 2
//                 ? const Icon(Icons.person)
//                 : const Icon(Icons.person_outline),
//             label: 'Profile',
//           ),
//         ],
//         selectedIconTheme:
//             IconThemeData(size: AppSize.heightDivide(context, 30)),
//         unselectedIconTheme:
//             IconThemeData(size: AppSize.heightDivide(context, 30)),
//         selectedItemColor: AppColor.oFF8A00,
//         unselectedItemColor: AppColor.gA5A5A5,
//         selectedLabelStyle: AppText.montserrat40008pxoFF8A00,
//         unselectedLabelStyle: AppText.montserrat40008pxgA5A5A5,
//       ),
//     );
//   }
// }

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {


  List<Map<String, dynamic>> mapList = [
    {
      'iconO': Icon(
        Icons.search,
        color: AppColor.wFFFFFF,
      ),
      'iconF': Icon(Icons.search, color: AppColor.wFFFFFF),
      'label': 'Search',
    },
    {
      'iconO': Icon(Icons.home_outlined, color: AppColor.wFFFFFF),
      'iconF': Icon(Icons.home, color: AppColor.wFFFFFF),
      'label': 'Home',
    },
    {
      'iconO': Icon(Icons.person_outline, color: AppColor.wFFFFFF),
      'iconF': Icon(Icons.person, color: AppColor.wFFFFFF),
      'label': 'Profile',
    }
  ];

  List<Widget> pages = [
    const SearchNewScreen(),
    const HomePage(),
    const Profile(),
  ];

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        height: AppSize.heightDivide(context, 13.333),
        width: AppSize.widthMultiply(context, 1),
        decoration: BoxDecoration(color: AppColor.wFAFAFA, boxShadow: [
          BoxShadow(
              offset: const Offset(4, 0),
              blurRadius: 4,
              color: AppColor.b000000w10)
        ]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(mapList.length, (e) {
              return SizedBox(
                height: AppSize.heightDivide(context, 24),
                width: AppSize.widthDivide(context, 6),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = e;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShaderMask(
                        // child: mapList[e]['iconO'],
                        child: selectedIndex == e
                            ? mapList[e]['iconF']
                            : mapList[e]['iconO'],
                        shaderCallback: (border) {
                          final Rect rect = Rect.fromLTRB(0, 0, 25, 22);
                          return selectedIndex == e
                              ? LinearGradient(
                                  colors: [
                                    AppColor.oFFB319,
                                    AppColor.oFF8A00,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ).createShader(rect)
                              : LinearGradient(
                                  colors: [
                                    AppColor.gA5A5A5,
                                    AppColor.gA5A5A5,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ).createShader(rect);
                        },
                      ),
                      selectedIndex == e
                          ? AppText.gradientFFB319wo100nFF8A00wo100(
                              mapList[e]['label'], 8, FontWeight.w400)
                          : Text(
                              mapList[e]['label'],
                              style: AppText.montserrat40008pxgA5A5A5,
                            ),
                    ],
                  ),
                ),
              );
            },
            ),
        ),
      ),
    );
  }
}
