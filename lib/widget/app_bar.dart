import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';


import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';
import '../screen/search_page/search_content.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar(
      {super.key,
      required this.searchField,
      required this.cartCall,
      required this.menuCall});
  final Function cartCall;
  final Function menuCall;
  final bool searchField;
  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppSize.widthDivide(context, 16),
          vertical: AppSize.heightDivide(context, 40)),
      height: AppSize.heightDivide(context, 8.6666),
      width: AppSize.widthMultiply(context, 1),
      // color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText.gradientFFB319wo100nFF8A00wo100(
                  'Gorgeous Bags', 18, FontWeight.w600),
              SizedMedia.widthDivide(context, 2.8),
              GestureDetector(
                onTap: () {
                  widget.cartCall();
                },
                child: Iconify(
                  Ic.baseline_shopping_bag,
                  size: AppSize.widthDivide(context, 20),
                  color: AppColor.b000000,
                ),
              ),
              SizedMedia.widthDivide(context, 25),
              GestureDetector(
                onTap: () {
                  widget.menuCall();
                },
                child: Iconify(
                  Ic.baseline_menu,
                  size: AppSize.widthDivide(context, 16),
                  color: AppColor.b000000,
                ),
              )
            ],
          ),
          InkWell(
            onTap: () {
              if (widget.searchField == false) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const SearchContent())));
              }
            },
            child: Container(
              height: AppSize.heightDivide(context, 18.6046),
              width: AppSize.widthMultiply(context, 1),
              decoration: BoxDecoration(
                  color: AppColor.gF5F5F5,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 20,
                        color: AppColor.b000000w6)
                  ]),
              child: TextFormField(
                enabled: widget.searchField,
                style: AppText.montserrat50012pxb403C3C,
                controller: search,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Iconify(
                      Ic.outline_search,
                      color: AppColor.b000000,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColor.gF5F5F5,
                  hintText: 'Search',
                  hintStyle: AppText.montserrat50012pxb000000w33,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: AppColor.gF5F5F5,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: AppColor.gF5F5F5,
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppBarWidget extends StatefulWidget {
  const AppBarWidget(
      {super.key, required this.menuCall, required this.cartCall});
  final Function cartCall;
  final Function menuCall;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          // horizontal: AppSize.widthDivide(context, 15.8),
          vertical: AppSize.heightDivide(context, 80)),
      height: AppSize.heightDivide(context, 19),
      width: AppSize.widthMultiply(context, 1),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.widthDivide(context, 15.8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText.gradientFFB319wo100nFF8A00wo100(
                'Gorgeous Bags', 18, FontWeight.w600),
            SizedMedia.widthDivide(context, 2.8),
            GestureDetector(
              onTap: () {
                widget.cartCall();
              },
              child: Iconify(
                Ic.baseline_shopping_bag,
                size: AppSize.widthDivide(context, 20),
                color: AppColor.b000000,
              ),
            ),
            SizedMedia.widthDivide(context, 25),
            GestureDetector(
              onTap: () {
                widget.menuCall();
              },
              child: Iconify(
                Ic.baseline_menu,
                size: AppSize.widthDivide(context, 16),
                color: AppColor.b000000,
              ),
            )
          ],
        ),
      ),
    );
  }
}

AppBar otherAppBar(BuildContext context, String text) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColor.b000000,
        )),
    title: AppText.gradientFFB319wo100nFF8A00wo100(text, 20, FontWeight.w600),
  );
}

AppBar cancelAppBar(BuildContext context, String text) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          CupertinoIcons.multiply,
          color: AppColor.b000000,
        )),
    title: AppText.gradientFFB319wo100nFF8A00wo100(text, 18, FontWeight.w600),
  );
}
