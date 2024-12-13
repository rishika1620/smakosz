import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smakosz/Screens/wallet.dart';
import 'package:smakosz/Services/database.dart';
import 'package:smakosz/Services/shared_pref.dart';

import '../Widgets/widget_support.dart';
import 'item_details.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  String? id, wallet, cartItemId;
  int total = 0,amount_required = 0;

  void startTimer(){
    Timer(Duration(seconds: 1), (){
      amount_required = total;
      setState(() {

      });
    });
  }
  getSharedPref() async {
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {

    });
  }

  ontheLoad() async {
    await getSharedPref();
    cartFoodStream = await DatabaseMethod().getCartItems(id!);
    setState(() {

    });
  }
  placeOrder() async{
    showDialog(context: context, builder: (BuildContext context){
      return amount_required > int.parse(wallet!)? AlertDialog(
        title: Text("Insufficient Balance!", style: AppWidget.boldTextFieldStyle(),),
        content: Text("Add money to wallet to proceed with Order", style: TextStyle(
          fontSize: 15,
        ),),
        actions: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)
                    ),

                    child: Text("Cancel", style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () async {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wallet()));
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text("Add Money", style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),),
                  ),
                ),
              )
            ],
          ),

        ],
      )  :  AlertDialog(
        title: Text("Confirm Order", style: AppWidget.headLineTextFieldStyle(),),
        content: Text("Amount of ₨.${amount_required} will be deducted from your wallet", style: TextStyle(
          fontSize: 15,
        ),),
        actions: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)
                    ),

                    child: Text("Back", style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () async {
                  int amount = int.parse(wallet!) - amount_required;
                  await DatabaseMethod().UpdateUserWallet(id!,amount.toString());
                  await SharedPreferenceHelper().saveUserWallet(amount.toString());
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.black,
                      content: Text("Your order has been placed successfully!", style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),)));
                  Navigator.pop(context);

                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text("Place Order", style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),),
                  ),
                ),
              )
            ],
          ),
        ],
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    ontheLoad();
    startTimer();
    super.initState();
  }

  Stream? cartFoodStream;
 /* Widget cartItems(){
    return StreamBuilder(stream: cartFoodStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index){
            DocumentSnapshot ds = snapshot.data.docs[index];

            total = total + int.parse(ds["Total Amount"]);

            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),

                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10,),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(ds["Image"], height: 75, width: 75,fit: BoxFit.cover,)),
                      SizedBox(width: 20.0,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 170,
                            child: Text(ds["Name"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppWidget.semiBoldTextFieldStyle(),),
                          ),
                          Text("₨. " + ds["Total Amount"], style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),),
                          Text("Item Count: "+ds["Quantity"], ),
                        ],
                      ),

                       GestureDetector(
                          onTap: () async {
                            cartItemId = ds.id;
                            await DatabaseMethod().deleteFoodItem(id!, cartItemId!);
                            setState(() {
                              total = total - int.parse(ds["Total Amount"]);
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center ,
                            children: [
                              Icon(Icons.delete, color: Colors.black,),
                              SizedBox(height: 5,),
                              Text("Delete Item", style: TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                              ),)
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );

          }) : CircularProgressIndicator();
    });
  }*/
  Widget cartItems() {
    return StreamBuilder(
      stream: cartFoodStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        // Calculate the total price once
        List<DocumentSnapshot> cartItems = snapshot.data.docs;
        total = cartItems.fold(0, (sum, ds) => sum + int.parse(ds["Total Amount"]));

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: cartItems.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = cartItems[index];

            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          ds["Image"],
                          height: 75,
                          width: 75,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 170,
                            child: Text(
                              ds["Name"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppWidget.semiBoldTextFieldStyle(),
                            ),
                          ),
                          Text(
                            "₨. " + ds["Total Amount"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text("Item Count: " + ds["Quantity"]),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          cartItemId = ds.id;
                          int itemTotal = int.parse(ds["Total Amount"]);
                          await DatabaseMethod().deleteFoodItem(id!, cartItemId!);
                          setState(() {
                            // Recalculate the total after deletion
                            cartItems.removeAt(index);
                            total -= itemTotal;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.delete, color: Colors.black),
                            SizedBox(height: 5),
                            Text(
                              "Delete Item",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Center(child: Text("Your Cart", style: AppWidget.headLineTextFieldStyle(),)),
              ),
            ),

            Container(
                height: MediaQuery.of(context).size.height/1.55,
                child: cartItems()),
            Spacer(),
            Divider(),

            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Price", style: AppWidget.boldTextFieldStyle(),),
                  Text("₨." + total.toString(), style: AppWidget.semiBoldTextFieldStyle(),)
                ],
              ),
            ),

            SizedBox(height: 20.0,),
            GestureDetector(
              onTap: placeOrder,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Center(
                  child: Text("Place Order", style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
