import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/screen/address/newAddress.dart';

import '../../../helper/button.dart';
import '../../../helper/colors.dart';
import '../../../helper/size.dart';
import '../../../helper/text_style.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/list_tile.dart';
import 'order_summary.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  var selectItem, addressId;

  QuerySnapshot? snapshot;
  bool loading = false;

  void getData() async {
    setState(() {
      loading = true;
    });

    snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('address')
        .get();

    setState(() {
      loading = false;
    });
  }

  void updateSelectedAddress()async{
    setState(() {
      loading = true;
    });
    if(selectItem !=null){
      await FirebaseFirestore.instance.collection('users').
      doc(FirebaseAuth.instance.currentUser!.uid).update({
        'shipping-address' : [addressId],
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OrderSummary()));
    }else{
      print('its value');
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: otherAppBar(context, 'Select Address'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Divider(
                thickness: 1,
                color: AppColor.gF1F1F1w78,
              ),
              addAddressListTile(context, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewAddressPage(),
                  ),
                );
              }),
              Divider(
                thickness: 1,
                color: AppColor.gF1F1F1w78,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('address')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No address is present',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Acme',
                          letterSpacing: 1.5,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length -1,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.widthDivide(context, 25),
                        ),
                        height: AppSize.heightDivide(context, 12),
                        width: AppSize.widthMultiply(context, 1),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Radio(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                                activeColor: AppColor.oFF8A00,
                                value: index +1,
                                groupValue: selectItem,
                                onChanged: (value) {
                                  setState(() {
                                    selectItem = value;
                                    addressId = snapshot.data!.docs[index +1]['id'];
                                  });
                                }),
                            SizedMedia.widthDivide(context, 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.data!.docs[index +1]['first_name']} ${snapshot.data!.docs[index +1]['last_name']}',
                                  style: AppText.montserrat60015pxg9E9E9E,
                                ),
                                SizedMedia.heightDivide(context, 140),
                                SizedBox(
                                  width: AppSize.widthDivide(context, 1.53),
                                  child: Text(
                                    '${snapshot.data!.docs[index +1]['address']},${snapshot.data!.docs[index +1]['landmark']},${snapshot.data!.docs[index +1]['city']},${snapshot.data!.docs[index +1]['country']},${snapshot.data!.docs[index +1]['pincode']}',
                                    style: AppText.montserrat60010pxg9E9E9E,
                                  ),
                                ),
                                Text(
                                  'phone number- ${snapshot.data!.docs[index +1]['phone_number']}',
                                  style: AppText.montserrat60010pxg9E9E9E,
                                )
                              ],
                            ),
                            button49(context, () {})
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        thickness: 1,
                        color: AppColor.gF1F1F1w78,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        bottomSheet: bottomSheetButton(
            context, () {
              updateSelectedAddress();
        }, 'Deliver Here'),
      ),
    );
  }
}
