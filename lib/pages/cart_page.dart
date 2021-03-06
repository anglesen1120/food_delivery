import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:food_delivery/scoped_model/card_scoped_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext buildcontext) {
    return ScopedModelDescendant<CartScopedModel>(
        builder: (context, child, model) => Scaffold(
            resizeToAvoidBottomPadding: true,
            body: Stack(
              children: <Widget>[
                    model.cartItems.length != 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (buildcontext, i) {
                              
                              return _buildCartAdapter(i, context, model);
                            },
                            itemCount: model.cartItems.length,
                          )
                        : Align(
                          alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CachedNetworkImage(
                                  imageUrl: 'https://firebasestorage.googleapis.com/v0/b/food-delivery-leo.appspot.com/o/Coffee.png?alt=media&token=4b2540b5-ada6-4dce-ae2e-5452754dedd9',
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Text('IT SEEMS YOU HAVN"T ADDED ANY PRODUCTS YET !',style: TextStyle(
                                  fontSize: 12 , color: Colors.black, fontWeight: FontWeight.bold
                                ),)
                              ],
                            )
                                
                          ),

                // Align(
                //   child: Container(
                //     // decoration: BoxDecoration(),
                //     padding: EdgeInsets.all(16),
                //     height: 100,
                //     width: double.infinity,
                //     color: Colors.white,
                //     child: Stack(
                //       children: <Widget>[
                //         Align(
                //           alignment: Alignment.bottomRight,
                //           child: Container(
                //             margin: EdgeInsets.only(right: 14, bottom: 8),
                //             child: OutlineButton(
                //               color: Colors.green,
                //               onPressed: () async {
                //                 FirebaseUser user = await _auth.currentUser();
                //                 if (user == null)
                //                   openLoginSheet(buildcontext);
                //                 else {
                //                   print('logged in');
                //                 }
                //               },
                //               child: Text(
                //                 'Checkout',
                //                 style: TextStyle(color: Colors.black),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //   alignment: Alignment.bottomCenter,
                // )
              ],
            )));
  }

  Widget _buildCartAdapter(int index, BuildContext context, CartScopedModel model) {
    var width = MediaQuery.of(context).size.width / 1.75;
    var product = model.cartItems[index];
    return InkWell(
      // onTap: () => _showBottomSheet(context, food: product),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              // Container(
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: NetworkImage(product.image),
              //       ),
              //       shape: BoxShape.rectangle,
              //       borderRadius: BorderRadius.all(Radius.circular(5))),
              //   margin: EdgeInsets.only(left: 16, top: 5, right: 5, bottom: 5),
              //   height: 50,
              //   width: 50,
              // ),
              Container(
                padding: EdgeInsets.all(8),
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Text(
                        product.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        "Rs.${product.price * product.count}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          color: Color(0xFF212121),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                // width: width,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                       model.updateItemCount(index, false);
                      },
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 1,
                      ),
                    ),
                    child: Container(
                      width: 25,
                      height: 25,
                      // padding: EdgeInsets.all(8),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          product.count.toString(),
                          style: TextStyle(
                            color: Colors.black,
                              fontSize: 13, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        model.updateItemCount(index, true);
                      },
                    ),
                  ),
                ],
              ),)
            ],
          ),
              
              
          Divider()
        ],
      ),
    );
  }
}
