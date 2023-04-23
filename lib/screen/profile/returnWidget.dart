import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/screen/profile/return_request_details.dart';
import 'package:intl/intl.dart';

import '../../component/loading.dart';
import '../../helper/colors.dart';
import '../../helper/size.dart';
import '../../helper/text_style.dart';
import '../../widget/app_bar.dart';

class ReturnRefundPage extends StatefulWidget {
  const ReturnRefundPage({Key? key}) : super(key: key);

  @override
  State<ReturnRefundPage> createState() => _ReturnRefundPageState();
}

class _ReturnRefundPageState extends State<ReturnRefundPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.wFAFAFA,
        appBar: otherAppBar(context, 'Return Product'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.widthDivide(context, 16),
                vertical: AppSize.heightDivide(context, 80)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('refunds').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

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
                          'This category \n\n has no items yet !',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Acme',
                              letterSpacing: 1.5),
                        ),
                      );
                    }

                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                              vertical:
                              AppSize.heightDivide(context, 60),
                            ),
                            height: AppSize.heightDivide(context, 6.1538),
                            width: AppSize.widthMultiply(context, 1),
                            child: FutureBuilder(
                                future: FirebaseFirestore.instance.collection('product').doc(snapshot.data!.docs[index]['productId']).get(),
                                builder: (context, snapshotFuture2) {

                                  if (snapshotFuture2.hasError) {
                                    return const Center(
                                      child: Text(
                                          "Something went wrong"),
                                    );
                                  }

                                  if (snapshotFuture2.connectionState == ConnectionState.done) {
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ReturnRequestDetails(refundId: snapshot.data!.docs[index]['id'],)));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColor.oFFB319.withOpacity(0.2)),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: AppSize.widthDivide(
                                                  context, 3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    6),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      snapshotFuture2
                                                          .data!
                                                          .data()![
                                                      'profile']),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedMedia.widthDivide(context, 40),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  width: AppSize.widthDivide(
                                                      context, 2.2),
                                                  child: Text(
                                                    'Refund id:- ${snapshot.data!.docs[index]['id']}',
                                                    style: AppText
                                                        .montserrat40010pxb000000w69,
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),

                                                SizedBox(
                                                  width: AppSize.widthDivide(context, 2.2),
                                                  child: Text(
                                                    snapshotFuture2.data!.data()!['name'],
                                                    style: AppText.montserrat60013pxb000000,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),

                                                SizedBox(
                                                  width: AppSize.widthDivide(
                                                      context, 2.2),
                                                  child: Text(
                                                    'Refund Status :- ${snapshot.data!.docs[index]['refundStatus']}',
                                                    style: AppText
                                                        .montserrat40012pxb000000,
                                                    maxLines: 2,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                ),

                                              ],
                                            ),
                                            // Padding(
                                            //   padding: EdgeInsets.only(
                                            //     bottom: AppSize.heightDivide(
                                            //         context, 10),
                                            //     // left: AppSize.widthDivide(context, 7),
                                            //   ),
                                            //   child: InkWell(
                                            //     borderRadius:
                                            //     BorderRadius.circular(10),
                                            //     onTap: () {
                                            //
                                            //     },
                                            //     child: Icon(
                                            //       Icons.arrow_forward_ios,
                                            //       color: AppColor.b000000,
                                            //       size: AppSize.heightDivide(
                                            //           context, 40.666),
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  return const LoadingScreen();
                                }),
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
