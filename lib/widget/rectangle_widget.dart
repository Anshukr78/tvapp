import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../component/loading.dart';
import '../helper/button.dart';
import '../helper/colors.dart';
import '../helper/size.dart';
import '../helper/text_style.dart';
import '../screen/home_page/place_an_order/select_address.dart';

Widget searchRectangle(BuildContext context) {
  return InkWell(
    onTap: () {},
    child: Container(
      height: AppSize.heightDivide(context, 36.3636),
      width: AppSize.widthDivide(context, 4.9315),
      decoration: BoxDecoration(
        color: AppColor.gD9D9D9w23,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: Text(
          'Food',
          style: AppText.montserrat50011pxbl0077B6w25,
        ),
      ),
    ),
  );
}

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({super.key});

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: AppSize.widthDivide(context, 80)),
      height: AppSize.heightDivide(context, 44.444),
      width: AppSize.widthDivide(context, 4.7368),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(width: 0.5, color: AppColor.gC1C1C1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Quantity:',
            style: AppText.montserrat40010pxb000000,
          ),
          Container(
            width: AppSize.widthDivide(context, 18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(width: 0.5, color: AppColor.gC1C1C1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '1',
                  style: AppText.montserrat40010pxb000000,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.expand_less,
                          color: AppColor.b000000,
                          size: AppSize.heightDivide(context, 100.7046),
                        )),
                    InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.expand_more,
                          color: AppColor.b000000,
                          size: AppSize.heightDivide(context, 100.7046),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget earnedRectangleWidget(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: AppSize.heightDivide(context, 60)),
    padding: EdgeInsets.symmetric(
        horizontal: AppSize.widthDivide(context, 30),
        vertical: AppSize.heightDivide(context, 80)),
    height: AppSize.heightDivide(context, 5.2631),
    width: AppSize.widthMultiply(context, 1),
    decoration: BoxDecoration(
        color: AppColor.gF5F5F5, borderRadius: BorderRadius.circular(13)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppSize.widthDivide(context, 36),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Earned',
                style: AppText.montserrat50012pxb000000w36,
              ),
              SizedMedia.heightDivide(context, 100),
              Text(
                "5001.00",
                style: AppText.montserrat60024pxb403C3C,
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: AppColor.b000000w4,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.widthDivide(context, 36),
              vertical: AppSize.heightDivide(context, 100)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total\nReferrals',
                    style: AppText.montserrat50010pxb000000w36,
                  ),
                  SizedMedia.heightDivide(context, 80),
                  Text(
                    '100',
                    style: AppText.montserrat60010pxb403C3C,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'Total Order\nPlaced',
                    style: AppText.montserrat50010pxb000000w36,
                  ),
                  SizedMedia.heightDivide(context, 80),
                  Text(
                    '20',
                    style: AppText.montserrat60010pxb403C3C,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'Payment\nPending',
                    style: AppText.montserrat50010pxb000000w36,
                  ),
                  SizedMedia.heightDivide(context, 80),
                  Text(
                    '120.89',
                    style: AppText.montserrat60010pxb403C3C,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget productDetailsWidget(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: AppSize.heightDivide(context, 70),
    ),
    height: AppSize.heightDivide(context, 5.2),
    width: AppSize.widthMultiply(context, 1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSize.heightDivide(context, 20),
              width: AppSize.widthDivide(context, 1.9047),
              child: Text(
                'tokyo talkies slim fit women blue trousers',
                style: AppText.montserrat60013pxb000000,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Text(
                  '30,',
                  style: AppText.montserrat50012pxg9E9E9E,
                ),
                Text(
                  'Blue',
                  style: AppText.montserrat50012pxg9E9E9E,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'seller: ',
                  style: AppText.montserrat50012pxg9E9E9E,
                ),
                Text(
                  'RetailNet',
                  style: AppText.montserrat50012pxg9E9E9E,
                ),
              ],
            ),
            SizedMedia.heightDivide(context, 120),
            Row(
              children: [
                Text(
                  '40',
                  style: AppText.montserrat60020pxb000000,
                ),
                SizedMedia.widthDivide(context, 30),
                AppText.gradientFFB319wo100nFF8A00wo100(
                    '1 Offer', 12, FontWeight.w700)
              ],
            ),
            SizedMedia.heightDivide(context, 100),
            Text(
              'Delivery By Oct 26',
              style: AppText.montserrat40012pxb000000,
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: AppSize.heightDivide(context, 6.3816),
              width: AppSize.widthDivide(context, 3.7894),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  image: const DecorationImage(
                      image: AssetImage('images/bagpack.jpg'),
                      fit: BoxFit.cover)),
            ),
            const QuantityWidget(),
          ],
        ),
      ],
    ),
  );
}

Widget returnRequestDetaildWidget(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: AppSize.heightDivide(context, 50)),
    padding: EdgeInsets.symmetric(
      vertical: AppSize.heightDivide(context, 27),
      horizontal: AppSize.widthDivide(context, 13),
    ),
    height: AppSize.heightDivide(context, 5.4421),
    width: AppSize.widthMultiply(context, 1),
    decoration: BoxDecoration(
        color: AppColor.oFFB319,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
            color: AppColor.oFF8A00,
            width: 1,
            strokeAlign:  BorderSide.strokeAlignInside)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Return ID - ',
              style: AppText.montserrat60012pxb403C3C,
            ),
            Text(
              '#12345678',
              style: AppText.montserrat60012pxb403C3C,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Reason - ',
              style: AppText.montserrat60012pxb403C3C,
            ),
            Text(
              'Item Or Product Defective',
              style: AppText.montserrat60012pxb403C3C,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Return Quantity - ',
              style: AppText.montserrat60012pxb403C3C,
            ),
            Text(
              '1',
              style: AppText.montserrat60012pxb403C3C,
            ),
          ],
        ),
      ],
    ),
  );
}



class DeliverAddressWidget extends StatefulWidget {
  final List selectedAddressIndex;
  const DeliverAddressWidget({Key? key, required this.selectedAddressIndex}) : super(key: key);

  @override
  State<DeliverAddressWidget> createState() => _DeliverAddressWidgetState();
}

class _DeliverAddressWidgetState extends State<DeliverAddressWidget> {

  // var addressIndex;
  // void getUserData()async{
  //   final userReference = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('address').doc(widget.selectedAddressIndex[0]).get();
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   getUserData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppSize.heightDivide(context, 80)),
      height: AppSize.heightDivide(context, 6.1538),
      width: AppSize.widthMultiply(context, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deliver To:',
                style: AppText.montserrat70014pxb000000,
              ),
              button76(context, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectAddress(),),);
              }),
            ],
          ),
          widget.selectedAddressIndex.isEmpty ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: AppText.gradientFFB319wo100nFF8A00wo100('Please select address', 16, FontWeight.bold),
            ),
          )
              :

          FutureBuilder<DocumentSnapshot>(

            future: FirebaseFirestore.instance.collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('address').doc(widget.selectedAddressIndex[0]).get(),

            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){

              if (snapshot.hasError) {
                return const Center(child: Text("Something went wrong"),);
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Center(child: Text("Document does not exist"),);
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
                print(data);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedMedia.heightDivide(context, 80),
                    Text(
                      '${data['first_name']} ${data['last_name']}',
                      style: AppText.montserrat40014pxb000000,
                    ),
                    SizedMedia.heightDivide(context, 200),
                    Text(
                      '${data['address']},${data['landmark']},${data['city']},${data['country']},${data['pincode']}',
                      style: AppText.montserrat40014pxb000000,
                    ),
                    SizedMedia.heightDivide(context, 200),
                    Text(
                      '${data['phone_number']}',
                      style: AppText.montserrat40014pxb000000,
                    ),
                  ],
                );
              }

              return const LoadingScreen();
            },
          ),

        ],
      ),
    );
  }
}





Widget deliverAddressWidget(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: AppSize.heightDivide(context, 80)),
    height: AppSize.heightDivide(context, 6.1538),
    width: AppSize.widthMultiply(context, 1),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Deliver To:',
              style: AppText.montserrat70014pxb000000,
            ),
            button76(context, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectAddress()));
            }),
          ],
        ),
        SizedMedia.heightDivide(context, 80),
        Text(
          'John Kipling',
          style: AppText.montserrat40014pxb000000,
        ),
        SizedMedia.heightDivide(context, 200),
        Text(
          '29, green valley,tower of liberty, new york, united states,46231',
          style: AppText.montserrat40014pxb000000,
        ),
        SizedMedia.heightDivide(context, 200),
        Text(
          '7623456402',
          style: AppText.montserrat40014pxb000000,
        ),
      ],
    ),
  );
}

Widget priceDetailsWidget(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: AppSize.heightDivide(context, 80)),
    height: AppSize.heightDivide(context, 7.2072),
    width: AppSize.widthMultiply(context, 1),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Details',
          style: AppText.montserrat60013pxb000000,
        ),
        SizedMedia.heightDivide(context, 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Price(1 item)',
              style: AppText.montserrat40012pxb000000,
            ),
            Text(
              '45',
              style: AppText.montserrat40012pxb000000,
            ),
          ],
        ),
        SizedMedia.heightDivide(context, 220),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Discount',
              style: AppText.montserrat40012pxb000000,
            ),
            Text(
              '-5',
              style: AppText.montserrat40012pxb000000,
            ),
          ],
        ),
        SizedMedia.heightDivide(context, 220),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery Charges',
              style: AppText.montserrat40012pxb000000,
            ),
            Text(
              'FREE',
              style: AppText.montserrat40012pxb000000,
            ),
          ],
        ),
        Divider(
          color: AppColor.gF1F1F1w78,
          thickness: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Amount',
              style: AppText.montserrat50012pxb000000,
            ),
            Text(
              '40',
              style: AppText.montserrat50012pxb000000,
            ),
          ],
        ),
      ],
    ),
  );
}
