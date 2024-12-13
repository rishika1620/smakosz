import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smakosz/Services/database.dart';
import 'package:smakosz/Services/shared_pref.dart';

import '../Widgets/widget_support.dart';

class Item_Details extends StatefulWidget {
  String image,name,details, price;

  Item_Details({super.key, required this.image, required this.name, required this.details, required this.price});

  @override
  State<Item_Details> createState() => _Item_DetailsState();
}

class _Item_DetailsState extends State<Item_Details> {

  int no_of_items = 1, total = 0;
  String? id;

  getUserId() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {

    });
  }

  ontheLoad()async{
    await getUserId();
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    total = int.parse(widget.price);
    ontheLoad();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  },
                child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,)),
            Image.network(
              widget.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.5,
              fit: BoxFit.fill,),

            SizedBox(height: 10,),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: AppWidget.semiBoldTextFieldStyle(),),
                  ],
                ),

                Spacer(),
                GestureDetector(
                  onTap: (){
                    if(no_of_items>1) {
                      --no_of_items;
                      setState(() {
                        total = total - int.parse(widget.price);
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.remove, color: Colors.white,),
                  ),
                ),
                SizedBox(width: 15,),
                Text(no_of_items.toString(),style: AppWidget.semiBoldTextFieldStyle(),),
                SizedBox(width: 15,),
                GestureDetector(
                  onTap: (){
                    ++no_of_items;
                    setState(() {
                      total = total + int.parse(widget.price);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.add, color: Colors.white,),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20,),
            
            Text(
              widget.details,
              style: AppWidget.lightTextFieldStyle(),
              maxLines: 4,
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Text("Delivery Time",style: AppWidget.semiBoldTextFieldStyle(), ),
                SizedBox(width: 25,),
                Icon(Icons.alarm, color: Colors.black54,),
                SizedBox(width: 5,),
                Text("30 min", style: AppWidget.semiBoldTextFieldStyle(),)
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Price", style: AppWidget.semiBoldTextFieldStyle(),),
                      Text("₨ " + total.toString(), style: AppWidget.semiBoldTextFieldStyle(),),
                    ],
                  ),

                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addFoodtoCart = {
                        "Name" : widget.name,
                        "Quantity" : no_of_items.toString(),
                        "Total Amount" : total.toString(),
                        "Image" : widget.image,
                      };

                      await DatabaseMethod().addFoodItemtoCart(addFoodtoCart, id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.orangeAccent,
                              content: Text("Item Added to Cart", style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Add to Cart", style:GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ),),

                          SizedBox(width: 30,),

                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.shopping_cart_outlined, color: Colors.white,),
                          ),
                          SizedBox(width: 10,),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
