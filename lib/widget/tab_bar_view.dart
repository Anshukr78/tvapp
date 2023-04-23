import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harbour_ecommerce/model/product.dart';

import '../screen/product_details_screen.dart';
import 'grid_view_box.dart';


class TrendingTabBarView extends StatefulWidget {
  const TrendingTabBarView({Key? key}) : super(key: key);

  @override
  State<TrendingTabBarView> createState() => _TrendingTabBarViewState();
}

class _TrendingTabBarViewState extends State<TrendingTabBarView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('product')
            .snapshots(),
        builder: (BuildContext context,  AsyncSnapshot<QuerySnapshot> snapshot){

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
                ));
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length > 10 ? 10 : snapshot.data!.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 25,
                crossAxisSpacing: 25,
                childAspectRatio: 139 / 199),
            itemBuilder: ((context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return ProductDetailsScreen(
                        productClass: ProductClass(
                            imageUrl: snapshot.data!.docs[index]['profile'],
                            productPrice: snapshot.data!.docs[index]['price'],
                            size: snapshot.data!.docs[index]['size'],
                            brand: snapshot.data!.docs[index]['brand'],
                            category: snapshot.data!.docs[index]['category'],
                            id: snapshot.data!.docs[index]['id'],
                            productDescrition: snapshot.data!.docs[index]['description'],
                            productName: snapshot.data!.docs[index]['name'],
                            qty: 1
                        ),
                      );
                    },),);
                  },
                  child: searchGridViewBox(
                      context: context,
                    imageUrl: snapshot.data!.docs[index]['profile'],
                    title: snapshot.data!.docs[index]['name'],
                    price: snapshot.data!.docs[index]['price'].toString(),
                    description: snapshot.data!.docs[index]['description'],
                    brand: snapshot.data!.docs[index]['brand'],
                  ),
              );
            }),
          );
        }
    );
  }
}




//
// Widget trendingTabBarView(BuildContext context) {
//   return GridView.builder(
//     shrinkWrap: true,
//     physics: NeverScrollableScrollPhysics(),
//     itemCount: 10,
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 25,
//         crossAxisSpacing: 25,
//         childAspectRatio: 139 / 150),
//     itemBuilder: ((context, index) {
//       return GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return ProductDetailsScreen(
//                   productImage:
//                       'https://assets.ajio.com/medias/sys_master/root/20220830/nXiV/630dd14cf997dd1f8dc5d756/-473Wx593H-464453675-grey-MODEL.jpg',
//                   productTitle: 'HandBag',
//                   productPrice: '300',
//                   productDescription:
//                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.');
//             }));
//           },
//           child: searchGridViewBox(
//             context: context,
//             imageUrl: snapshot.data!.docs[index]['profile'],
//             title: snapshot.data!.docs[index]['name'],
//             price: snapshot.data!.docs[index]['price'],
//             description: snapshot.data!.docs[index]['description'],
//             brand: snapshot.data!.docs[index]['brand'],
//           ));
//     }),
//   );
// }

Widget offersTabBarView(BuildContext context) {
  return Container();
}
