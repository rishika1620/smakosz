import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smakosz/Screens/item_details.dart';
import 'package:smakosz/Services/database.dart';
import 'package:smakosz/Services/shared_pref.dart';
import 'package:smakosz/Widgets/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool ice_cream =false;
  bool pizza =false;
  bool burger =false;
  bool salad =false;
  
  Stream? foodItemStream;
  String? userName;

  getSharedPref() async {
    userName = await SharedPreferenceHelper().getUserName();
    setState(() {

    });
  }
  LoadItems() async {
    foodItemStream = await DatabaseMethod().getFoodItems("Pizza");
    await getSharedPref();
    setState(() {
      
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    LoadItems();
    super.initState();
  }

  Widget allItems(){
    return StreamBuilder(stream: foodItemStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            DocumentSnapshot ds = snapshot.data.docs[index];
            return Container(
              height: 250,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Item_Details(image: ds["Image"], details: ds["Detail"], price: ds["Price"], name: ds["Name"],)));
                },
                child: Container(
                  width: 175,
                  height: 275,
                  margin: EdgeInsets.all(4),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 275,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                ds["Image"],
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            ds["Name"], style: AppWidget.semiBoldTextFieldStyle(),),
                          SizedBox(height: 5,),
                          Text(ds["Detail"],
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,

                            ),),
                          SizedBox(height: 5,),
                          Text("₨. " + ds["Price"], style: AppWidget.semiBoldTextFieldStyle(),)
                        ],

                      ),
                    ),
                  ),
                ),
              ),
            );

          }) : CircularProgressIndicator();
    });
  }
  
  Widget allItemsVertically(){
    return StreamBuilder(stream: foodItemStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index){
            DocumentSnapshot ds = snapshot.data.docs[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Item_Details(image: ds["Image"], details: ds["Detail"], price: ds["Price"], name: ds["Name"],)));
              },
              child: Container(
                padding: EdgeInsets.only(right: 20),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(ds["Image"], height: 100, width: 100, fit: BoxFit.cover,)),
                        SizedBox(width: 20,),
                        Column(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width/2,
                                child: Text(
                                  ds["Name"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppWidget.semiBoldTextFieldStyle(),)),
                            SizedBox(height: 5,),
                            Container(
                                width: MediaQuery.of(context).size.width/2,
                                child: Text(ds["Detail"],
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                  ),)),
                            SizedBox(height: 5,),

                            Container(
                                width: MediaQuery.of(context).size.width/2,
                                child: Text("₨. "+ ds["Price"], style: AppWidget.semiBoldTextFieldStyle(),))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );

      }) : CircularProgressIndicator();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 10,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hello ${userName}, ", style: AppWidget.boldTextFieldStyle(),),
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.shopping_cart, color: Colors.white,),
                )
              ],
            ),

            SizedBox(height: 30,),

            Text("Delicious Food", style: AppWidget.headLineTextFieldStyle(),),
            Text("Discover and Get Great Food", style: AppWidget.lightTextFieldStyle(),),

            SizedBox(height: 20,),

            showItem(),

            //SizedBox(height: 20,),
           /* Container(
                height: 250,
                child: allItems()),*/
            SizedBox(height: 30,),

            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height/1.75,
                child: allItemsVertically(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showItem(){
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              burger= true;
              pizza = false;
              salad= false;
              ice_cream = false;
              foodItemStream = await DatabaseMethod().getFoodItems("Burger");
              setState(() {

              });
            },
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color:  burger?Colors.black: Colors.white,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2), // Circular border
                    ),
                    child: Image.asset(
                      "assets/images/burger.jpg",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              burger= false;
              pizza = false;
              salad= false;
              ice_cream = true;
              foodItemStream = await DatabaseMethod().getFoodItems("Ice-cream");
              setState(() {

              });
            },
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: ice_cream?Colors.black : Colors.white,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: Image.asset(
                      "assets/images/ice_cream.jpg",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),),

          GestureDetector(
            onTap: () async {
              burger= false;
              pizza = true;
              salad= false;
              ice_cream = false;
              foodItemStream = await DatabaseMethod().getFoodItems("Pizza");
              setState(() {

              });
            },
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: pizza?Colors.black : Colors.white,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: Image.asset(
                      "assets/images/pizza.jpg",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),),
          GestureDetector(
            onTap: () async {
              burger= false;
              pizza = false;
              salad= true;
              ice_cream = false;
              foodItemStream = await DatabaseMethod().getFoodItems("Salad");
              setState(() {

              });
            },
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: salad?Colors.black : Colors.white,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: Image.asset(
                      "assets/images/salad.jpg",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
