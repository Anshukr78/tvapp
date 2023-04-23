import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../helper/button.dart';
import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/widgets/text_field_widget.dart';
import '../../widget/app_bar.dart';

import '../home_page/place_an_order/select_address.dart';

class NewAddressPage extends StatefulWidget {
  const NewAddressPage({Key? key}) : super(key: key);

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  final keyValue = Uuid().v4();
  bool isLoading = false;

  saveAddress() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('address')
        .doc(keyValue)
        .set({
      'id': keyValue,
      'first_name': firstNameController.text.trim(),
      'last_name': lastNameController.text.trim(),
      'phone_number': phoneController.text.trim(),
      'address': addressController.text.trim(),
      'landmark': landmark.text.trim(),
      'city': city.text.trim(),
      'country': country.text.trim(),
      'pincode': zipCode.text.trim(),
      'lat': '',
      'long': '',
    });
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SelectAddress(),
      ),
    );
  }

  verifyData() {
    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        country.text.isNotEmpty &&
        city.text.isNotEmpty &&
        zipCode.text.isNotEmpty &&
        landmark.text.isNotEmpty &&
        phoneController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      saveAddress();
    }
  }

  TextEditingController country = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.wFAFAFA,
      appBar: otherAppBar(context, 'Order Summary'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: customTextField(
                        controller: firstNameController,
                        keyboardType: TextInputType.text,
                        hintText: 'Your First Name'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: customTextField(
                        controller: lastNameController,
                        keyboardType: TextInputType.text,
                        hintText: 'Your Last Name'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: customTextField(
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  hintText: 'Address'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: customTextField(
                  controller: phoneController,
                  keyboardType: TextInputType.text,
                  hintText: 'Phone number'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: customTextField(
                  controller: landmark,
                  keyboardType: TextInputType.text,
                  hintText: 'Landmark'),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: customTextField(
                        controller: zipCode,
                        keyboardType: TextInputType.text,
                        hintText: 'Zip code'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: customTextField(
                        controller: city,
                        keyboardType: TextInputType.text,
                        hintText: 'City'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: customTextField(
                  controller: country,
                  keyboardType: TextInputType.text,
                  hintText: 'Country'),
            ),
          ],
        ),
      ),
      bottomSheet: isLoading
          ? Container(
              height: AppSize.heightDivide(context, 14.5148),
              width: AppSize.widthMultiply(context, 1),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColor.oFFB319, AppColor.oFF8A00],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: SizedBox(
                  width: AppSize.heightDivide(context, 14.5148),
                  child: const CircularProgressIndicator()),
            )
          : bottomSheetButton(context, () {
              verifyData();
            }, 'Save Address'),
    );
  }
}
